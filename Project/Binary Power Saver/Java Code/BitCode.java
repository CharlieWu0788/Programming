public class BitCode
{
    public static int calculateSupply(String code, Battery battery)
    {
        int total = 0;

        for (int i = 0; i < code.length(); i++)
        {
            if (code.charAt(i) == '1')
            {
                total = total + battery.getEnergyAtBit(i);
            }
        }

        return total;
    }
}