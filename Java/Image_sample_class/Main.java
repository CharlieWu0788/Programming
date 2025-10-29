//Importing all the stuff Java needs to work with images
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;

//Creating the class to display the image
class ImageDisplay extends JFrame {

    public ImageDisplay(BufferedImage image) {
        setTitle("Image Display"); //A title for the image
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);//Making sure it closes
        
        //Stuff that needs to happen (don't worry about it)
        ImageIcon icon = new ImageIcon(image);
        JLabel label = new JLabel(icon);

        add(label);
        pack();
        setVisible(true);
    }
}

public class Main {
    public static void main(String[] args) {
        //Try attempts to execute a code, returns an error if it failed
        try {
            
            //Reads the image
            File imageFile = new File("image_1.jpg"); // Replace with your image file name
            BufferedImage image = ImageIO.read(imageFile); //Reads the file

            // ####### This is where we're going to code #######
            int width,height,x,y,rgb,red,green,blue,new_rgb;

            width = image.getWidth();
            height = image.getHeight();
            System.out.println("Width: " + width);
            System.out.println("Height: " + height);
            
            //Go through every pixel of our image
            for (x = 0; x < width; x++) {
                 for (y = 0; y < height; y++) {
                      rgb = image.getRGB(x, y);
                      red = rgb & 0xFF0000;
                      green = rgb & 0x00FF00;
                      blue = rgb & 0x0000FF;
                      new_rgb = 0xFFFFFF - rgb;
                      //image.setRGB(x, y, new_rgb);
                 }
            }

            
            // ####### This is where our code should end #######
            new ImageDisplay(image); //Shows the image
        //This is the code to "catch" the error
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}