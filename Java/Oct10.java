public class Oct10
{
    public static class Friend
    {
        String name;
        int age;
        boolean in_touch;
    }
    public static void main(String[] args)
    {
        Friend mark = new Friend();
        mark.name = "Mark";
        mark.age = 67;
        mark.in_touch = true;
        printFriendInfo(mark);
        String info = getFriendInfo(mark);
        System.out.println("[info string] " + info);
    }

    public static void printFriendInfo(Friend friend)
    {
        System.out.println(getFriendInfo(friend));
    }

    public static String getFriendInfo(Friend friend)
    {
        return friend.name + " is " + friend.age + " years old, and we are " + (friend.in_touch ? "in touch." : "not in touch.");
    }
}
