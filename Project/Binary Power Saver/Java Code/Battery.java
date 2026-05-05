public class Battery
{
    private int power;
    private int duration;
    private int baseEnergy;

    public Battery(int power, int duration)
    {
        this.power = power;
        this.duration = duration;
        this.baseEnergy = power * duration;
    }

    public int getEnergyAtBit(int index)
    {
        int divider = 1;

        for (int i = 0; i < index; i++)
        {
            divider = divider * 2;
        }

        return baseEnergy / divider;
    }
}