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

    /*
    public void setYear(int Year)
    {
        if(Year > 1800 && Year < 2025)
        {
            this.year = Year;
        }
        else
        {
            System.out.println("Sorry, the year typed is either to old to be a movie or it is set in the future.");
            this.year = 0;
        }
    }
    public int getYear()
    {
        return this.year;
    }
    */

    public void printAllInfo()
    {
        String title = getTitle();
        int length = getTime();
        String genre = getGenre();
        boolean fresh = getIs_fresh();
        System.out.println("--- Movie Info ---");
        System.out.println("Title: " + title);
        System.out.println("Length: " + length + " min");
        System.out.println("Genre: " + genre);
        System.out.println("Fresh: " + fresh);
    }

}

public class Oct17
{
    public  static void main(String[] args)
    {
        Movie pulp_fiction = new Movie();
        pulp_fiction.setTitle("Pulp Fiction");
        pulp_fiction.setTime(154);
        pulp_fiction.setGenre("Crime");
        pulp_fiction.setIs_fresh(true);
        pulp_fiction.printAllInfo();
    }
}
