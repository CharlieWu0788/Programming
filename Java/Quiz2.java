/*
 * import java.util.Scanner;
import java.util.ArrayList; //Inventory should be an ArrayList

class Store_Item
{
    private String name;
    private String size;
    private String color;
    private double price;

    public Store_Item(String name, String size, String color, double price)
    {
        this.name = name;
        this.size = size;
        this.color = color;
        this.price = price;
    }
    public String getName()
    {
        return name;
    }
    public String getSize()
    {
        return size;
    }
    public String getColor()
    {
        return color;
    }
    public double getPrice()
    {
        return price;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public void setSize(String size)
    {
        this.size = size;
    }
    public void setColor(String color)
    {
        this.color = color;
    }
    public void setPrice(double price)
    {
        this.price = price;
    }
    @Override
    public String toString()
    {
        return name+", "+size+", "+color+", $"+price;
    }

}

class Top extends Store_Item
{
    private String sleeves;

    public Top(String name, String size, String color, double price, String sleeves)
    {
        super(name, size, color, price);
        this.sleeves = sleeves;
    }
    public String getSleeves()
    {
        return sleeves;
    }
    public void setSleeves(String sleeves)
    {
        this.sleeves = sleeves;
    }
    @Override
    public String toString()
    {
        return getName()+", "+sleeves+", "+getSize()+", "+getColor()+",  $"+getPrice();
    }
}

class Bottom extends Store_Item
{
    private String length;

    public Bottom(String name, String size, String color, double price, String length)
    {
        super(name, size, color, price);
        this.length = length;
    }
    public String getLength()
    {
        return length;
    }
    public void setLength(String length)
    {
        this.length = length;
    }
    @Override
    public String toString()
    {
        return getName()+", "+length+", "+getSize()+", "+getColor()+", $"+getPrice();
    }
}

class Store
{
    private ArrayList<Store_Item> inventory;

    public Store()
    {
        inventory = new ArrayList<Store_Item>();
    }

    public void addItem(Store_Item item)
    {
        inventory.add(item);
    }

    public int showItemsOverValue(double value)
    {
        int count = 0;
        for (Store_Item item : inventory)
        {
            if (item.getPrice() >= value)
            {
                count++;
            }
        }
        return count;
    }

    public void showInventory()
    {
        for (Store_Item item : inventory)
        {
            System.out.println(item);
        }
    }
}

public class Quiz2
{
    public static void main(String[] args)
    {
        
        Store myStore = new Store();

        Bottom bottom4 = new Bottom("Sneakers with Memory Foam Insole", "10", "Silver", 34.99, "");
        myStore.addItem(bottom4);
        Top top1 = new Top("Cozy Rib Hoodie", "M", "Pink", 28.0, "Long");
        myStore.addItem(top1);
        Bottom bottom1 = new Bottom("Mid-Rise Cargo Joggers", "L", "Moss Green", 20.8, "Ankle");
        myStore.addItem(bottom1);
        Bottom bottom2 = new Bottom("Running Shoes", "7", "Clay", 29.97, "");
        myStore.addItem(bottom2);
        Top top2 = new Top("Hooded Sweatshirt", "XL", "Light Green", 25.0, "Long");
        myStore.addItem(top2);
        Bottom bottom3 = new Bottom("Run Shorts", "S", "Red", 15.0, "5''");
        myStore.addItem(bottom3);
        myStore.showInventory();
        System.out.println("");
        int usd_10 = myStore.showItemsOverValue(10);
        System.out.println("The store has " + usd_10 + " item(s) over $10.");

        int usd_20 = myStore.showItemsOverValue(20);
        System.out.println("The store has " + usd_20 + " item(s) over $20.");

        int usd_30 = myStore.showItemsOverValue(30);
        System.out.println("The store has " + usd_30 + " item(s) over $30.");
    }
}
 */