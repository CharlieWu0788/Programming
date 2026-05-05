import java.util.HashMap;
import java.util.Map;

public class SymbolTable {
    private Map<String, Symbol> classScope = new HashMap<>();
    private Map<String, Symbol> subroutineScope = new HashMap<>();

    private int staticCount = 0;
    private int fieldCount = 0;
    private int argCount = 0;
    private int varCount = 0;

    public void startSubroutine() {
        subroutineScope.clear();
        argCount = 0;
        varCount = 0;
    }

    public void define(String name, String type, String kind) {
        int index;

        switch (kind) {
            case "static": index = staticCount++; classScope.put(name, new Symbol(type, kind, index)); break;
            case "field": index = fieldCount++; classScope.put(name, new Symbol(type, kind, index)); break;
            case "arg": index = argCount++; subroutineScope.put(name, new Symbol(type, kind, index)); break;
            case "var": index = varCount++; subroutineScope.put(name, new Symbol(type, kind, index)); break;
        }
    }

    public int varCount(String kind) {
        switch (kind) {
            case "static": return staticCount;
            case "field": return fieldCount;
            case "arg": return argCount;
            case "var": return varCount;
        }
        return 0;
    }

    public String kindOf(String name) {
        if (subroutineScope.containsKey(name)) return subroutineScope.get(name).kind;
        if (classScope.containsKey(name)) return classScope.get(name).kind;
        return null;
    }

    public String typeOf(String name) {
        if (subroutineScope.containsKey(name)) return subroutineScope.get(name).type;
        if (classScope.containsKey(name)) return classScope.get(name).type;
        return null;
    }

    public int indexOf(String name) {
        if (subroutineScope.containsKey(name)) return subroutineScope.get(name).index;
        if (classScope.containsKey(name)) return classScope.get(name).index;
        return -1;
    }

    private static class Symbol {
        String type, kind;
        int index;

        Symbol(String t, String k, int i) {
            type = t;
            kind = k;
            index = i;
        }
    }
}