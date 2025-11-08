import java.util.*;

public class Lab7
{
    public static void main(String[] args)
    {
        //Fibonacci Sequence
        int index = getFibonacciIndex();
        int result = getFibonacci(index);
        printFibonacciResult(index, result);
    
        //Remove Gray (now using RGBA with floats 0.0-1.0)
        float[] rgba = getRGBAValue();
        float[] rgbaNoGray = removeGray(rgba);
        printRGBAwithoutGray(rgbaNoGray);
    }

    public static int getFibonacciIndex()
    {
        int index;
        try (Scanner scnr = new Scanner(System.in))
        {
            System.out.println("Please enter the Fibonacci index you wish to know:");
            index = scnr.nextInt();
        }
        return index;
    }

    public static int getFibonacci(int n)
    {
        if (n < 0)
        {
            return -1;
        }
        else if (n == 0)
        {
            return 0;
        }
        else if (n == 1)
        {
            return 1;
        }
        else
        {
            return getFibonacci(n - 1) + getFibonacci(n - 2);
        }
    }

    public static void printFibonacciResult(int index, int result)
    {
        System.out.println("fibonacci(" + index + ") is " + result);
    }

    public static float[] getRGBAValue()
    {
    int R, G, B;
    float A;
    try (Scanner scnr = new Scanner(System.in)) {
        System.out.println("Please enter the amount of red (0-255):");
        R = scnr.nextInt();
        System.out.println("Please enter the amount of green (0-255):");
        G = scnr.nextInt();
        System.out.println("Please enter the amount of blue (0-255):");
        B = scnr.nextInt();
        System.out.println("Please enter the amount of alpha (0.0-1.0), use 1.0 for opaque:");
        A = scnr.nextFloat();
    }
    return new float[]{R/255f, G/255f, B/255f, A};
    }

    public static float[] removeGray(float[] rgba)
    {
        float g = Math.min(rgba[0], Math.min(rgba[1], rgba[2]));
        return new float[]{rgba[0] - g, rgba[1] - g, rgba[2] - g, rgba[3]};
    }

    public static void printRGBAwithoutGray(float[] rgbaNoGray)
    {
        System.out.printf("The color without gray is %.3f %.3f %.3f Alpha: %.3f%n", rgbaNoGray[0], rgbaNoGray[1], rgbaNoGray[2], rgbaNoGray[3]);
    }

}