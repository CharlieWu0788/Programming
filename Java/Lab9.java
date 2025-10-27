import java.util.*;
class Pet
{

    private String name;
    private int age;

    public void setName(String name)
    {
        this.name = name;
    }
    public void setAge(int age)
    {
        this.age = age;
    }

    public String getName()
    {
        return this.name;
    }
    public int getAge()
    {
        return this.age;
    }

    public Pet(String a_name,  int a_age)
    {
        this.name = a_name;
        this.age = a_age;
    }
    @Override
    public String toString()
    {
        return "Cat Information: " +"\n"+
        "   Name: "+ this.name +"\n"+
        "   Age: "+ this.age;
    }

    public void talk(int talk)
    {
        for (int i=0; i<talk; i+=1){
            System.out.println("Generic animal sound");
        }
    }
}

class Dog extends Pet
{
    private String breed;
    public Dog(String name, int age, String breed)
    {
        super(name, age);
        this.setBreed(breed);
        this.setAge(age);
    }
    
    public void setBreed(String bread)
    {
        this.breed = bread;
    }
    public String getBreed()
    {
        return this.breed;
    }
    public String toString()
    {
        return "Dog Information: " +"\n"+
        "   Name: "+ this.getName() +"\n"+
        "   Age: "+ this.getAge() +"\n"+
        "   Breed: "+this.breed;
    }
    public void talk(int talk)
    {
        for (int i=0; i<talk; i+=1)
        {
            System.out.println("Woof");
        }
    }

}
//Don't forget to override the talk() method

public class Lab9
{
    public static void main(String[] args)
    {
        String name;
        String breed;
        int age;
        int num_talk;
        
        Scanner input = new Scanner(System.in);
        System.out.println("Please enter the name of the pet:");
        name = input.nextLine();
        System.out.println("Please enter the breed of the pet:");
        breed = input.nextLine();
        System.out.println("Please enter the age:");
        age = input.nextInt();
        System.out.println("Please enter the number of times to talk:");
        num_talk = input.nextInt();
        Dog info = new Dog(name, age, breed);
        System.out.println(info);
        info.talk(num_talk);

        input.close();
    }
}