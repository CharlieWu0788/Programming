import java.util.Scanner;
public class Oct08
{
    public static void main(String[] args)
    {
        Scanner scnr = new Scanner(System.in);
        //Mad Libs Java
        String first_name;
        int whole_number;
        double decimal_number;
        String plural_noun;
        String generic_location;
        double cost;
        System.out.println("Please enter a name:");
        first_name = scnr.next();
        System.out.println("Please enter a whole number:");
        whole_number = scnr.nextInt();
        System.out.println("Please enter a number with decimals:");
        decimal_number = scnr.nextDouble();
        System.out.println("Please enter a plural noun:");
        plural_noun = scnr.next();
        System.out.println("Please enter a location:");
        generic_location = scnr.next();
        cost = whole_number * decimal_number;
        System.out.println(first_name + " buys " + whole_number + " different types of "+ plural_noun + " for $" + cost + " at " + generic_location);
        scnr.close();
        
        //Smallest number and sum Java
        int num1, num2, num3, sum;
        System.out.println("Please enter a whole number:");
        num1 = scnr.nextInt();
        System.out.println("Please enter another whole number:");
        num2 = scnr.nextInt();
        System.out.println("Please enter another whole number:");
        num3 = scnr.nextInt();
        sum = num1 + num2 + num3;
        int min = Math.min(num1, Math.min(num2, num3));
        System.out.println("The smallest number is " + min);
        System.out.println("The sum of all the numbers is " + sum);
        
        //Printing a text multiple times
        String textToRepeat;
        int repeatCount;

        System.out.println("Please enter a text to repeat:");
        textToRepeat = scnr.nextLine();

        System.out.println("Please enter a number of times to repeat:");
        repeatCount = scnr.nextInt();

        for (int i = 0; i < repeatCount; i++)
        {
            System.out.println(textToRepeat);
        }

        //Converting Fahrenheit to Celsius Java
        double fahrenheit, celsius;
        System.out.println("Please enter how many Fahrenheit to convert:");
        fahrenheit = scnr.nextDouble();
        celsius = (fahrenheit - 32) * 5 / 9;
        System.out.println(fahrenheit + " Fahrenheit is equivalent to " + celsius + " Celsius.");
   }
    
}