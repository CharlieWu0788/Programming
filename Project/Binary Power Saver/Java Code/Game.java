import java.util.Scanner;

public class Game
{
    private Battery battery;
    private Scanner scanner;
    private int score;

    public Game()
    {
        battery = new Battery(1000, 40);
        scanner = new Scanner(System.in);
        score = 0;
    }

    public void start()
    {
        while (true)
        {
            int demand = generateDemand();
            int requiredEnergy = demand * 40;

            System.out.println("Demand: " + demand + " W");
            System.out.println("Required Energy: " + requiredEnergy);

            System.out.print("Enter 8-bit code: ");
            String code = scanner.nextLine();

            int supply = BitCode.calculateSupply(code, battery);

            System.out.println("Supply: " + supply);

            if (supply < requiredEnergy)
            {
                System.out.println("FAIL: Not enough power");
                break;
            }
            else
            {
                int waste = supply - requiredEnergy;
                int roundScore = Math.max(0, 100 - waste / 100);

                score += roundScore;

                System.out.println("Waste: " + waste);
                System.out.println("Score gained: " + roundScore);
                System.out.println("Total Score: " + score);
            }
        }
    }

    private int generateDemand()
    {
        return 500 + (int)(Math.random() * 1500);
    }
}