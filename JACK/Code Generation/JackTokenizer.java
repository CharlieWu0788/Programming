import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.*;

public class JackTokenizer
{
    private final List<String> tokens;
    private int currentIndex;
    private String currentToken;

    private static final Set<String> KEYWORDS = new HashSet<>(Arrays.asList(
            "class", "constructor", "function", "method", "field", "static",
            "var", "int", "char", "boolean", "void", "true", "false", "null",
            "this", "let", "do", "if", "else", "while", "return"
    ));

    private static final Set<Character> SYMBOLS = new HashSet<>(Arrays.asList(
            '{', '}', '(', ')', '[', ']', '.', ',', ';',
            '+', '-', '*', '/', '&', '|', '<', '>', '=', '~'
    ));

    public JackTokenizer(File file) throws IOException
    {
        String content = Files.readString(file.toPath());
        content = removeComments(content);
        this.tokens = tokenize(content);
        this.currentIndex = -1;
        this.currentToken = null;
        advance();
    }

    public boolean hasMoreTokens()
    {
        return currentIndex < tokens.size() - 1;
    }

    public void advance()
    {
        if (currentIndex + 1 < tokens.size())
        {
            currentIndex++;
            currentToken = tokens.get(currentIndex);
        }
        else
        {
            currentToken = null;
        }
    }

    public String getCurrentToken()
    {
        return currentToken;
    }

    public String peek()
    {
        if (currentIndex + 1 < tokens.size())
        {
            return tokens.get(currentIndex + 1);
        }
        return null;
    }

    public TokenType tokenType()
    {
        if (currentToken == null)
        {
            return null;
        }

        if (KEYWORDS.contains(currentToken))
        {
            return TokenType.KEYWORD;
        }

        if (currentToken.length() == 1 && SYMBOLS.contains(currentToken.charAt(0)))
        {
            return TokenType.SYMBOL;
        }

        if (currentToken.startsWith("\"") && currentToken.endsWith("\""))
        {
            return TokenType.STRING_CONST;
        }

        if (currentToken.matches("\\d+"))
        {
            return TokenType.INT_CONST;
        }

        return TokenType.IDENTIFIER;
    }

    public String keyword()
    {
        return currentToken;
    }

    public char symbol()
    {
        return currentToken.charAt(0);
    }

    public String identifier()
    {
        return currentToken;
    }

    public int intVal()
    {
        return Integer.parseInt(currentToken);
    }

    public String stringVal()
    {
        return currentToken.substring(1, currentToken.length() - 1);
    }

    private String removeComments(String input)
    {
        StringBuilder result = new StringBuilder();
        boolean inBlockComment = false;
        boolean inLineComment = false;
        boolean inString = false;

        for (int i = 0; i < input.length(); i++)
        {
            char c = input.charAt(i);
            char next = (i + 1 < input.length()) ? input.charAt(i + 1) : '\0';

            if (!inBlockComment && !inLineComment && c == '"')
            {
                inString = !inString;
                result.append(c);
                continue;
            }

            if (!inString)
            {
                if (!inBlockComment && !inLineComment && c == '/' && next == '*')
                {
                    inBlockComment = true;
                    i++;
                    continue;
                }

                if (inBlockComment && c == '*' && next == '/')
                {
                    inBlockComment = false;
                    i++;
                    continue;
                }

                if (!inBlockComment && !inLineComment && c == '/' && next == '/')
                {
                    inLineComment = true;
                    i++;
                    continue;
                }

                if (inLineComment && c == '\n')
                {
                    inLineComment = false;
                    result.append('\n');
                    continue;
                }
            }

            if (!inBlockComment && !inLineComment)
            {
                result.append(c);
            }
        }

        return result.toString();
    }

    private List<String> tokenize(String input)
    {
        List<String> result = new ArrayList<>();
        int i = 0;

        while (i < input.length())
        {
            char c = input.charAt(i);

            if (Character.isWhitespace(c))
            {
                i++;
                continue;
            }

            if (SYMBOLS.contains(c))
            {
                result.add(String.valueOf(c));
                i++;
                continue;
            }

            if (c == '"')
            {
                int j = i + 1;
                while (j < input.length() && input.charAt(j) != '"')
                {
                    j++;
                }
                result.add(input.substring(i, j + 1));
                i = j + 1;
                continue;
            }

            int j = i;
            while (j < input.length()
                    && !Character.isWhitespace(input.charAt(j))
                    && !SYMBOLS.contains(input.charAt(j)))
            {
                j++;
            }

            result.add(input.substring(i, j));
            i = j;
        }

        return result;
    }
}