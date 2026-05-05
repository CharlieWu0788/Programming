import java.io.IOException;

public class CompilationEngine
{
    private JackTokenizer tk;
    private VMWriter vm;
    private SymbolTable st;

    private String className;
    private int labelIndex = 0;

    public CompilationEngine(JackTokenizer tokenizer, String output) throws IOException
    {
        this.tk = tokenizer;
        this.vm = new VMWriter(output);
        this.st = new SymbolTable();
    }

    public void compileClass() throws IOException
    {
        tk.advance(); 
        tk.advance(); 
        className = tk.identifier();

        tk.advance(); 

        while (tk.token().equals("static") || tk.token().equals("field"))
        {
            compileClassVarDec();
        }

        while (tk.token().equals("constructor") || tk.token().equals("function") || tk.token().equals("method"))
        {
            compileSubroutine();
        }
    }

    private void compileClassVarDec()
    {
        String kind = tk.token(); // static/field
        tk.advance();

        String type = tk.token();
        tk.advance();

        while (true)
        {
            String name = tk.identifier();
            st.define(name, type, kind);

            tk.advance();

            if (!tk.token().equals(","))
            {
                break;
            }
            tk.advance();
        }

        tk.advance();
    }

    private void compileSubroutine() throws IOException
    {
        st.startSubroutine();

        String subType = tk.token(); // constructor/function/method
        tk.advance(); 

        tk.advance(); 
        String name = tk.identifier();

        if (subType.equals("method"))
        {
            st.define("this", className, "arg");
        }

        tk.advance();
        compileParameterList();
        tk.advance();

        tk.advance();
        while (tk.token().equals("var"))
        {
            compileVarDec();
        }

        int nLocals = st.varCount("var");
        vm.function(className + "." + name, nLocals);

        if (subType.equals("constructor"))
        {
            vm.push("constant", st.varCount("field"));
            vm.call("Memory.alloc", 1);
            vm.pop("pointer", 0);
        }
        else if (subType.equals("method"))
        {
            vm.push("argument", 0);
            vm.pop("pointer", 0);
        }

        compileStatements();
        tk.advance(); 
    }

    private void compileParameterList()
    {
        if (tk.token().equals(")"))
        {
            return;
        }

        while (true)
        {
            String type = tk.token();
            tk.advance();

            String name = tk.identifier();
            st.define(name, type, "arg");

            tk.advance();

            if (!tk.token().equals(","))
            {
                break;
            }
            tk.advance();
        }
    }

    private void compileVarDec()
    {
        tk.advance();
        String type = tk.token();
        tk.advance();

        while (true)
        {
            String name = tk.identifier();
            st.define(name, type, "var");

            tk.advance();

            if (!tk.token().equals(","))
            {
                break;
            }
            tk.advance();
        }

        tk.advance(); // ;
    }

    private void compileStatements() throws IOException
    {
        while (true)
        {
            String t = tk.token();

            if (t.equals("let"))
            {
                compileLet();
            }
            else if (t.equals("if"))
            {
                compileIf();
            }
            else if (t.equals("while"))
            {
                compileWhile();
            }
            else if (t.equals("do"))
            {
                compileDo();
            }
            else if (t.equals("return"))
            {
                compileReturn();
            }
            else
            {
                break;
            }
        }
    }

    private void compileLet() throws IOException
    {
        tk.advance();
        String name = tk.identifier();

        String kind = st.kindOf(name);
        int index = st.indexOf(name);

        tk.advance();

        tk.advance();
        compileExpression();

        vm.pop(segmentOf(kind), index);

        tk.advance(); // ;
    }

    private void compileIf() throws IOException
    {
        int idx = labelIndex++;

        tk.advance();
        tk.advance();
        compileExpression();
        tk.advance();

        vm.ifGoto("IF_TRUE" + idx);
        vm.goTo("IF_FALSE" + idx);
        vm.label("IF_TRUE" + idx);

        tk.advance();
        compileStatements();
        tk.advance();

        if (tk.token().equals("else"))
        {
            vm.goTo("IF_END" + idx);
            vm.label("IF_FALSE" + idx);

            tk.advance(); 
            tk.advance(); 
            compileStatements();
            tk.advance(); 

            vm.label("IF_END" + idx);
        }
        else
        {
            vm.label("IF_FALSE" + idx);
        }
    }

    private void compileWhile() throws IOException
    {
        int idx = labelIndex++;

        vm.label("WHILE_EXP" + idx);

        tk.advance(); 
        tk.advance(); 
        compileExpression();
        tk.advance(); 

        vm.arithmetic("not");
        vm.ifGoto("WHILE_END" + idx);

        tk.advance(); 
        compileStatements();
        tk.advance(); 

        vm.goTo("WHILE_EXP" + idx);
        vm.label("WHILE_END" + idx);
    }

    private void compileDo() throws IOException
    {
        tk.advance(); 
        compileSubroutineCall();
        vm.pop("temp", 0);
        tk.advance(); 
    }

    private void compileReturn() throws IOException
    {
        tk.advance(); // return

        if (!tk.token().equals(";"))
        {
            compileExpression();
        }
        else
        {
            vm.push("constant", 0);
        }

        vm.ret();
        tk.advance(); 
    }

    private void compileExpression() throws IOException
    {
        compileTerm();

        while (isOp(tk.token()))
        {
            String op = tk.token();
            tk.advance();

            compileTerm();
            writeOp(op);
        }
    }

    private void compileTerm() throws IOException
    {
        if (tk.tokenType().equals("INT_CONST"))
        {
            vm.push("constant", tk.intVal());
            tk.advance();
        }
        else if (tk.tokenType().equals("IDENTIFIER"))
        {
            String name = tk.identifier();
            vm.push(segmentOf(st.kindOf(name)), st.indexOf(name));
            tk.advance();
        }
    }

    private void compileSubroutineCall() throws IOException
    {
        String name = tk.identifier();
        tk.advance();

        tk.advance(); 
        int n = compileExpressionList();
        tk.advance();

        vm.call(name, n);
    }

    private int compileExpressionList() throws IOException
    {
        int count = 0;

        if (tk.token().equals(")"))
        {
            return 0;
        }

        while (true)
        {
            compileExpression();
            count++;

            if (!tk.token().equals(","))
            {
                break;
            }
            tk.advance();
        }

        return count;
    }

    private boolean isOp(String s)
    {
        return "+-*/&|<>=".contains(s);
    }

    private void writeOp(String op) throws IOException
    {
        switch (op)
        {
            case "+":
                vm.arithmetic("add");
                break;
            case "-":
                vm.arithmetic("sub");
                break;
            case "*":
                vm.call("Math.multiply", 2);
                break;
            case "/":
                vm.call("Math.divide", 2);
                break;
            case "&":
                vm.arithmetic("and");
                break;
            case "|":
                vm.arithmetic("or");
                break;
            case "<":
                vm.arithmetic("lt");
                break;
            case ">":
                vm.arithmetic("gt");
                break;
            case "=":
                vm.arithmetic("eq");
                break;
        }
    }

    private String segmentOf(String kind)
    {
        switch (kind)
        {
            case "static":
                return "static";
            case "field":
                return "this";
            case "arg":
                return "argument";
            case "var":
                return "local";
        }
        return "";
    }
}