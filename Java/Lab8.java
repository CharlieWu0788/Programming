import java.util.*;
public class Lab8
{
    public static class Movie
    {
        private String title;
        private int year;
        private String genre;
        private String director;

        public void setTitle(String a_title)
        {
            this.title=a_title;
        }
        public String getTitle()
        {
            return this.title;
        }

        public void setYear(int year)
        {
            this.year=year;
        }
        public int getYear()
        {
            return this.year;
        }

        public void setGenre(String genre)
        {
            this.genre=genre;
        }
        public String getGenre()
        {
            return this.genre;
        }

        public void setDirector(String director)
        {
            this.director=director;
        }
        public String getDirector()
        {
            return this.director;
        }

        public void getAllInfo()
        {
            System.out.println("The movie " + this.getTitle() + " released in " + this.getYear() + " is a " + this.getGenre() + " film directed by " + this.getDirector() + ".");
        }
    }

    public static Movie[] createMovies()
    {
        Movie[] movies = new Movie[4];
        movies[0] = new Movie();
        movies[1] = new Movie();
        movies[2] = new Movie();
        movies[3] = new Movie();
        return movies;
    }
    
    public static void setMovies(Movie[] movies)
    {
        movies[0].setTitle("Garfield");
        movies[0].setYear(2024);
        movies[0].setGenre("Family/Comedy");
        movies[0].setDirector("Mark Dindal");

        movies[1].setTitle("Cars");
        movies[1].setYear(2006);
        movies[1].setGenre("Family/Comedy/Adventure");
        movies[1].setDirector("John Lasseter");

        movies[2].setTitle("Little Women");
        movies[2].setYear(2019);
        movies[2].setGenre("Romance/Drama");
        movies[2].setDirector("Greta Gerwig");

        movies[3].setTitle("The Matrix");
        movies[3].setYear(1999);
        movies[3].setGenre("Action/Sci-Fi");
        movies[3].setDirector("Lana Wachowski and Lilly Wachowski");
    }

    public static void getMovies(Movie[] movies)
    {
        for (Movie movie : movies)
        {
            movie.getAllInfo();
        }
    }

    public static class Student
    {
        private String name;
        private String id;
        private double gpa;

        public void setName(String student_name)
        {
            this.name = student_name;
        }
        public String getName()
        {
            return this.name;
        }

        public void setId(String id)
        {
            this.id = id;
        }
        public String getId()
        {
            return this.id;
        }

        public void setGpa(double gpa)
        {
            this.gpa = gpa;
        }
        public double getGpa()
        {
            return this.gpa;
        }

        public void getInfo()
        {
            System.out.println(this.getName() + ", with ID: " + this.getId() + ", has a GPA of " + this.getGpa() + ".");
        }
    }

    public static Student createStudent()
    {
        return new Student();
    }


    public static void setStudent(Student student, Scanner input)
    {
        String student_name;
        String id;
        double gpa;
        System.out.println("Please enter the student's name:");
        student_name = input.nextLine();
        System.out.println("Please enter the student's id:");
        id = input.nextLine();
        System.out.println("Please enter the student's GPA:");
        String gpaLine = input.nextLine();
        try
        {
            gpa = Double.parseDouble(gpaLine.trim());
        }
        catch (NumberFormatException e)
        {
            System.out.println("Invalid GPA input. Setting GPA to 0.0");
            gpa = 0.0;
        }
        student.setName(student_name);
        student.setId(id);
        student.setGpa(gpa);
    }

    public static void getStudent(Student student)
    {
        student.getInfo();
    }

    public static class Product
    {
        private String name;
        private double price;
        private int stock;
        private double total_value;

        public void setName(String name)
        {
            this.name = name;
        }
        public String getName()
        {
            return this.name;
        }

        public void setPrice(double price)
        {
            this.price = price;
        }
        public double getPrice()
        {
            return this.price;
        }

        public void setStock(int stock)
        {
            this.stock = stock;
        }
        public int getStock()
        {
            return this.stock;
        }
        public void setTotal_value(double total_value)
        {
            this.total_value = price * stock;
        }
        public double getTotal_value()
        {
            return this.total_value;
        }

        public void setInfo(String name, double price, int stock)
        {
            setName(name);
            setPrice(price);
            setStock(stock);
            setTotal_value(price * stock);
        }
        public void getInfo()
        {
            System.out.println("Name: " + getName());
            System.out.println("Price: " + getPrice());
            System.out.println("Quantity in stock: " + getStock());
            System.out.println("Total value in stock: " + getTotal_value());
            System.out.println();
        }
    }

    public static Product[] createProducts()
    {
        Product[] products = new Product[4];
        products[0] = new Product();
        products[1] = new Product();
        products[2] = new Product();
        products[3] = new Product();
        return products;
    }
    public static void setProducts(Product[] products)
    {
        products[0].setInfo("Apple", 0.4, 8);
        products[1].setInfo("Golden Delicious", 0.55, 3);
        products[2].setInfo("Pineapple", 10.5, 100);
        products[3].setInfo("Dragon fruit", 100.23, 123);

    }

    public static void getProducts(Product[] products)
    {
        for (Product product : products)
        {
            product.getInfo();
        }
    }
    public static void main(String[] args)
    {
        try (Scanner input = new Scanner(System.in))
        {
            boolean running = true;
            while (running)
            {
                System.out.println("\n=== Lab8 Menu ===");
                System.out.println("1) Movies (create & show)");
                System.out.println("2) Student (interactive)");
                System.out.println("3) Products (create & show)");
                System.out.println("4) Exit");
                System.out.print("Choose an option (1-4): ");
                String choice = input.nextLine().trim();

                switch (choice) {
                    case "1" -> {
                        Movie[] movies = createMovies();
                        setMovies(movies);
                        getMovies(movies);
                    }
                    case "2" -> {
                        Student s = createStudent();
                        setStudent(s, input);
                        getStudent(s);
                    }
                    case "3" -> {
                        Product[] products = createProducts();
                        setProducts(products);
                        getProducts(products);
                    }
                    case "4" -> {
                        running = false;
                        System.out.println("Exiting.");
                    }
                    default -> System.out.println("Invalid choice, please enter 1-4.");
                }
            }
        }
    }
}