import java.util.*;

public class Lab7
{
    public static void main(String[] args)
    {
        //Fibonacci Sequence
        int index = getFibonacciIndex();
        int result = getFibonacci(index);
        printFibonacciResult(index, result);
    
        //Remove Gray
        int[] rgb = getRGBValue();
        int[] rgbNoGray = removeGray(rgb);
        printRGBwithoutGray(rgbNoGray);
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

    public static int[] getRGBValue()
    {
    int R, G, B;
    try (Scanner scnr = new Scanner(System.in)) {
        System.out.println("Please enter the amount of red:");
        R = scnr.nextInt();
        System.out.println("Please enter the amount of green:");
        G = scnr.nextInt();
        System.out.println("Please enter the amount of blue:");
        B = scnr.nextInt();
    }
    return new int[]{R, G, B};
    }

    public static int[] removeGray(int[] rgb)
    {
        int g = Math.min(rgb[0], Math.min(rgb[1], rgb[2]));
        return new int[]{rgb[0] - g, rgb[1] - g, rgb[2] - g};
    }

    public static void printRGBwithoutGray(int[] rgbNoGray)
    {
        System.out.println("The color without gray is " + rgbNoGray[0] + " " + rgbNoGray[1] + " " + rgbNoGray[2]);
    }

}