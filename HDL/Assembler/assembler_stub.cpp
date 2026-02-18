#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <unordered_map>
#include <cctype>


using namespace std;

static string Trim(const string& s)
{
    size_t b = s.find_first_not_of(" \t\r\n");
    if (b == string::npos)
    {
        return "";
    }

    size_t e = s.find_last_not_of(" \t\r\n");
    return s.substr(b, e - b + 1);
}

static string StripInlineComment(const string& s)
{
    size_t pos = s.find("//");
    if (pos == string::npos)
    {
        return s;
    }
    return s.substr(0, pos);
}
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build (MSVC via VsDevCmd)",
      "type": "shell",
      "command": "cmd",
      "args": [
        "/d",
        "/c",
        "\"\"C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\Common7\\Tools\\VsDevCmd.bat\" -no_logo && cl /nologo /EHsc /std:c++17 \\\"${file}\\\"\""
      ],
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "problemMatcher": ["$msCompile"],
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}

static bool IsLabelLine(const string& s)
{
    return s.size() >= 3 && s.front() == '(' && s.back() == ')';
}

static string LabelName(const string& s)
{
    return Trim(s.substr(1, s.size() - 2));
}

static bool IsDecimalNumber(const string& s)
{
    if (s.empty())
    {
        return false;
    }

    for (char c : s)
    {
        if (!isdigit(static_cast<unsigned char>(c)))
        {
            return false;
        }
    }
    return true;
}

static string ToBinary16(uint16_t x)
{
    string out(16, '0');
    for (int i = 15; i >= 0; --i)
    {
        out[15 - i] = ((x >> i) & 1) ? '1' : '0';
    }
    return out;
}

static void SplitC(const string& line, string& dest, string& comp, string& jump)
{
    dest.clear();
    comp = line;
    jump.clear();

    size_t eq = comp.find('=');
    if (eq != string::npos)
    {
        dest = Trim(comp.substr(0, eq));
        comp = Trim(comp.substr(eq + 1));
    }

    size_t sc = comp.find(';');
    if (sc != string::npos)
    {
        jump = Trim(comp.substr(sc + 1));
        comp = Trim(comp.substr(0, sc));
    }
}

int main(int argc, char** argv)
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    if (argc != 2)
    {
        cerr << "Usage: " << argv[0] << " FILE.asm\n";
        return 2;
    }

    string inPath = argv[1];

    string outPath = inPath;
    size_t dot = outPath.find_last_of('.');
    if (dot != string::npos)
    {
        outPath = outPath.substr(0, dot);
    }
    outPath += ".hack";

    ifstream fin(inPath);
    if (!fin)
    {
        cerr << "Cannot open input file: " << inPath << "\n";
        return 2;
    }

    const unordered_map<string, string> DEST =
    {
        {"", "000"}, {"M", "001"}, {"D", "010"}, {"MD", "011"},
        {"A", "100"}, {"AM", "101"}, {"AD", "110"}, {"AMD", "111"}
    };

    const unordered_map<string, string> JUMP =
    {
        {"", "000"}, {"JGT", "001"}, {"JEQ", "010"}, {"JGE", "011"},
        {"JLT", "100"}, {"JNE", "101"}, {"JLE", "110"}, {"JMP", "111"}
    };

    const unordered_map<string, string> COMP =
    {
        {"0","0101010"},{"1","0111111"},{"-1","0111010"},{"D","0001100"},{"A","0110000"},
        {"!D","0001101"},{"!A","0110001"},{"-D","0001111"},{"-A","0110011"},
        {"D+1","0011111"},{"A+1","0110111"},{"D-1","0001110"},{"A-1","0110010"},
        {"D+A","0000010"},{"D-A","0010011"},{"A-D","0000111"},{"D&A","0000000"},{"D|A","0010101"},
        {"M","1110000"},{"!M","1110001"},{"-M","1110011"},{"M+1","1110111"},{"M-1","1110010"},
        {"D+M","1000010"},{"D-M","1010011"},{"M-D","1000111"},{"D&M","1000000"},{"D|M","1010101"}
    };

    unordered_map<string, int> symtab;
    symtab["SP"] = 0;
    symtab["LCL"] = 1;
    symtab["ARG"] = 2;
    symtab["THIS"] = 3;
    symtab["THAT"] = 4;
    symtab["SCREEN"] = 16384;
    symtab["KBD"] = 24576;

    for (int i = 0; i < 16; i++)
    {
        symtab["R" + to_string(i)] = i;
    }

    vector<pair<int, string>> cleaned;
    {
        string raw;
        int lineno = 0;

        while (getline(fin, raw))
        {
            lineno++;

            string line = Trim(StripInlineComment(raw));
            if (!line.empty())
            {
                cleaned.push_back({ lineno, line });
            }
        }
    }

    int rom = 0;
    for (const auto& p : cleaned)
    {
        const string& line = p.second;

        if (IsLabelLine(line))
        {
            string lab = LabelName(line);
            if (!lab.empty() && !symtab.count(lab))
            {
                symtab[lab] = rom;
            }
        }
        else
        {
            rom++;
        }
    }

    int nextVar = 16;
    vector<uint16_t> out;
    out.reserve(cleaned.size());

    for (const auto& p : cleaned)
    {
        int lineno = p.first;
        const string& line = p.second;

        if (IsLabelLine(line))
        {
            continue;
        }

        if (!line.empty() && line[0] == '@')
        {
            string symbol = Trim(line.substr(1));
            int addr = 0;

            if (IsDecimalNumber(symbol))
            {
                long long v = stoll(symbol);
                if (v < 0 || v > 32767)
                {
                    cerr << "A-instruction out of range at line " << lineno << ": " << line << "\n";
                    return 1;
                }
                addr = static_cast<int>(v);
            }
            else
            {
                if (!symtab.count(symbol))
                {
                    symtab[symbol] = nextVar;
                    nextVar++;
                }
                addr = symtab[symbol];
            }

            out.push_back(static_cast<uint16_t>(addr));
        }
        else
        {
            string dest;
            string comp;
            string jump;

            SplitC(line, dest, comp, jump);

            auto itC = COMP.find(comp);
            auto itD = DEST.find(dest);
            auto itJ = JUMP.find(jump);

            if (itC == COMP.end() || itD == DEST.end() || itJ == JUMP.end())
            {
                cerr << "Invalid C-instruction at line " << lineno << ": " << line << "\n";
                return 1;
            }

            string bits = "111" + itC->second + itD->second + itJ->second;

            uint16_t inst = 0;
            for (char b : bits)
            {
                inst = static_cast<uint16_t>((inst << 1) | (b == '1' ? 1 : 0));
            }

            out.push_back(inst);
        }
    }

    ofstream fout(outPath, ios::trunc);
    if (!fout)
    {
        cerr << "Cannot open output file: " << outPath << "\n";
        return 2;
    }

    for (size_t i = 0; i < out.size(); i++)
    {
        if (i != 0)
        {
            fout << "\n";
        }
        fout << ToBinary16(out[i]);
    }

    return 0;
}
