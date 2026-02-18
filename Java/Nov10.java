/*import java.util.ArrayList;

class Board_Game
{
    private String name;
    private double price;

    public Board_Game(String name, double price)
    {
        this.name = name;
        this.price = price;
    }
    public String getName()
    {
        return name;
    }
    public double getPrice()
    {
        return price;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public void setPrice(double price)
    {
        this.price = price;
    }
    @Override
    public String toString()
    {
        return name+", $"+price;
    }
}

class Video_Game extends Board_Game
{
    private String console;

    public Video_Game(String name, double price, String console)
    {
        super(name, price);
        this.console = console;
    }
    public String getConsole()
    {
        return console;
    }
    public void setConsole(String console)
    {
        this.console = console;
    }
    @Override
    public String toString()
    {
        return getName()+", "+console+", $"+getPrice();
    }
}

class Game_Store
{
    private ArrayList<Board_Game> inventory;

    public Game_Store()
    {
        inventory = new ArrayList<Board_Game>();
    }

    public void addToInventory(Board_Game game)
    {
        inventory.add(game);
    }

    public int countNameItems(String name)
    {
        // If search string is null or empty, return 0 (nothing to search for)
        if (name == null || name.isEmpty()) {
            return 0;
        }
        String search = name.toLowerCase();
        int count = 0;
        for (Board_Game game : inventory)
        {
            String gname = game.getName();
            if (gname != null && gname.toLowerCase().contains(search))
            {
                count++;
            }
        }
        return count;
    }

    public void showInventory()
    {
        for(Board_Game game : inventory)
        {
            System.out.println(game);
        }
    }
}
public class Nov10
{
    public static void main(String[] args)
    {
        Game_Store store = new Game_Store();

        Board_Game rummikub = new Board_Game("Rummikub", 20.0);
        Video_Game mario_kart = new Video_Game("Mario Kart 8 Deluxe", 60.0, "Nintendo Switch");
        Board_Game settlers = new Board_Game("Settlers of Catan", 45.0);
        Video_Game smash = new Video_Game("Super Smash Bros. Ultimate", 60.0, "Nintendo Switch");

        store.addToInventory(rummikub);
        store.addToInventory(mario_kart);
        store.addToInventory(settlers);
        store.addToInventory(smash);

        store.showInventory();

        System.out.println("");
        int num_rummi = store.countNameItems("Rummi");
        System.out.println("The store has " + num_rummi + " game(s) named Rummi.");

        int num_rummikub = store.countNameItems("Rummikub");
        System.out.println("The store has " + num_rummikub + " game(s) named Rummikub.");

        int num_smash = store.countNameItems("Smash");
        System.out.println("The store has " + num_smash + " game(s) named Smash.");
    }
}
*/