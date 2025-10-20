//import java.util.Scanner;
class Movie
{
    private String Title;
    private int Length_min;
    private String Genre;
    private boolean Is_fresh;

    public void setTitle(String Title)
    {
        this.Title = Title;
    }
    public String getTitle()
    {
        return this.Title;
    }

    public void setTime(int Length_min)
    {
        this.Length_min = Length_min;
    }
    public int getTime()
    {
        return this.Length_min;
    }

    public void setGenre(String Genre)
    {
        this.Genre = Genre;
    }
    public String getGenre()
    {
        return this.Genre;
    }

    public void setIs_fresh(boolean Is_fresh)
    {
        this.Is_fresh = Is_fresh;
    }
    public boolean getIs_fresh()
    {
        return this.Is_fresh;
    }

    public void getAllInfo()
    {
        System.out.print("Title: " + this.Title);
        System.out.print(" Length: " + this.Length_min + " min");
        System.out.print(" Genre: " + this.Genre);
        System.out.println(" Fresh: " + this.Is_fresh);
    }
}
public class Oct15
{
    public static void main(String[] args)
    {
        Movie pulp_fiction = new Movie();
        pulp_fiction.setTitle("Pulp Fiction");
        pulp_fiction.setTime(154);
        pulp_fiction.setGenre("Crime");
        pulp_fiction.setIs_fresh(true);
    }
}