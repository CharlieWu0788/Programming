import java.io.*;

public class VMWriter {
    private BufferedWriter writer;

    public VMWriter(String path) throws IOException {
        writer = new BufferedWriter(new FileWriter(path));
    }

    public void writePush(String segment, int index) throws IOException {
        writer.write("push " + segment + " " + index + "\n");
    }

    public void writePop(String segment, int index) throws IOException {
        writer.write("pop " + segment + " " + index + "\n");
    }

    public void writeArithmetic(String command) throws IOException {
        writer.write(command + "\n");
    }

    public void writeCall(String name, int nArgs) throws IOException {
        writer.write("call " + name + " " + nArgs + "\n");
    }

    public void writeFunction(String name, int nLocals) throws IOException {
        writer.write("function " + name + " " + nLocals + "\n");
    }

    public void writeReturn() throws IOException {
        writer.write("return\n");
    }

    public void close() throws IOException {
        writer.close();
    }
}