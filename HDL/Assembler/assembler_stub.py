#!/usr/bin/env python3
import argparse as ap
import os
import re
import sys

if __name__ == '__main__':

    parser = ap.ArgumentParser()
    parser.add_argument('file')
    args = parser.parse_args()

    infilename = args.file
    outfilename = os.path.splitext(infilename)[0] + '.hack'

    with open(infilename, 'r') as f:
        lines = list(enumerate(f, start=1))

    DEST_TABLE = {"": "000","M":"001","D":"010","MD":"011","A":"100","AM":"101","AD":"110","AMD":"111"}
    JUMP_TABLE = {"": "000","JGT":"001","JEQ":"010","JGE":"011","JLT":"100","JNE":"101","JLE":"110","JMP":"111"}
    COMP_TABLE = {
        "0":"0101010","1":"0111111","-1":"0111010","D":"0001100","A":"0110000",
        "!D":"0001101","!A":"0110001","-D":"0001111","-A":"0110011","D+1":"0011111",
        "A+1":"0110111","D-1":"0001110","A-1":"0110010","D+A":"0000010","D-A":"0010011",
        "A-D":"0000111","D&A":"0000000","D|A":"0010101",
        "M":"1110000","!M":"1110001","-M":"1110011","M+1":"1110111","M-1":"1110010",
        "D+M":"1000010","D-M":"1010011","M-D":"1000111","D&M":"1000000","D|M":"1010101",
    }

    symtab = {"SP":0,"LCL":1,"ARG":2,"THIS":3,"THAT":4,"SCREEN":16384,"KBD":24576}
    for i in range(16):
        symtab[f"R{i}"] = i

    label_re = re.compile(r"^\(([^)]+)\)$")

    cleaned = []
    for lineno, raw in lines:
        line = raw.split("//", 1)[0].strip()
        if line:
            cleaned.append((lineno, line))

    rom = 0
    for lineno, line in cleaned:
        m = label_re.match(line)
        if m:
            symtab.setdefault(m.group(1).strip(), rom)
        else:
            rom += 1

    def split_c(s):
        dest, comp, jump = "", s, ""
        if "=" in comp:
            dest, comp = comp.split("=", 1)
            dest, comp = dest.strip(), comp.strip()
        if ";" in comp:
            comp, jump = comp.split(";", 1)
            comp, jump = comp.strip(), jump.strip()
        return dest, comp, jump

    next_var = 16
    processed_lines = []

    for lineno, line in cleaned:
        if label_re.match(line):
            continue

        if line.startswith("@"):
            symbol = line[1:].strip()
            if symbol.isdigit():
                addr = int(symbol)
            else:
                if symbol not in symtab:
                    symtab[symbol] = next_var
                    next_var += 1
                addr = symtab[symbol]
            inst = addr
        else:
            dest, comp, jump = split_c(line)
            bits = "111" + COMP_TABLE[comp] + DEST_TABLE[dest] + JUMP_TABLE[jump]
            inst = int(bits, 2)

        processed_lines.append((lineno, inst))

    with open(outfilename, 'w') as of:
        for i, (_, inst) in enumerate(processed_lines):
            if i > 0:
                of.write("\n")
            of.write(f"{inst:016b}")

    sys.exit(os.EX_OK)