import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;

public class JackAnalyzer
{
    public static void main(String[] args)
    {
        if (args.length != 1)
        {
            System.out.println("Usage: java JackAnalyzer <input>");
            return;
        }

        File input = new File(args[0]);

        if (!input.exists())
        {
            return;
        }

        try
        {
            if (input.isDirectory())
            {
                File[] files = input.listFiles(new FilenameFilter()
                {
                    public boolean accept(File dir, String name)
                    {
                        return name.endsWith(".jack");
                    }
                });

                if (files != null)
                {
                    for (File f : files)
                    {
                        compileFile(f);
                    }
                }
            }
            else if (input.isFile() && input.getName().endsWith(".jack"))
            {
                compileFile(input);
            }
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    private static void compileFile(File file) throws IOException
    {
        String in = file.getAbsolutePath();
        String out = in.substring(0, in.lastIndexOf('.')) + ".vm";

        JackTokenizer tokenizer = new JackTokenizer(file);
        CompilationEngine engine = new CompilationEngine(tokenizer, out);
        engine.compileClass();
        engine.close();
    }
}