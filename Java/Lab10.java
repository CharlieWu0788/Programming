/*// Importing utility stuff
import java.util.ArrayList;

// Importing graphics stuff
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import javax.swing.JFrame;
import javax.swing.JPanel;

//Picture class to draw
class Picture extends JPanel
{
    private final int canvasWidth;
    private final int canvasHeight;

    private final ArrayList<GraphicsObject> objects;

    /* Constructor for a window/canvas of a specified size
     *
     * @param width  The width of the canvas.
     * @param height The height of the canvas.
     *
    public Picture(int width, int height)
    {
    this.canvasWidth = width;
    this.canvasHeight = height;
    this.objects = new ArrayList<>();
    }

    // Creates the window and shows it
    public void showCanvas()
    {
        JFrame frame = new JFrame("Picture");
        frame.getContentPane().add(this, BorderLayout.CENTER);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        Dimension dim = new Dimension(this.canvasWidth, this.canvasHeight);
        frame.getContentPane().setPreferredSize(dim);
        frame.pack();
        frame.setVisible(true);
    }

    // Convenience function to paint all objects.
    public void paint()
    {
        this.paint(this.getGraphics());
    }

    /* Paint/Draw the canvas.
     *
     * This function overrides the paint function in JPanel. This function is
     * automatically called when the panel is made visible.
     *
     * @param g The Graphics for the JPanel
     *
    @Override
    public void paint(Graphics g)
    {
        // use a for-each loop to draw each object
        for (GraphicsObject obj : this.objects)
        {
            obj.draw(g);
        }
    }

    /* Add an object to be draw.
     *
     * @param obj The object to draw.
     *
    public void addObject(GraphicsObject obj)
    {
        this.objects.add(obj);
    }

}

//This is a Graphics Object class (parent class for your objects)
class GraphicsObject
{
    int x;
    int y;

    public GraphicsObject(int x, int y)
    {
        this.x = x;
        this.y = y;
    }

    /* Draw the object
     *
     * This function should never be called directly, but should be overridden
     * by subclasses.
     *
     * @param g The Graphics for the JPanel
     *
    public void draw(Graphics g)
    {

    }
}

// ##### Here you declare classes that extend GraphicsObject ##### //
class All_shapes extends GraphicsObject
{
    // width/height not used for this simple demo shape; removed to avoid unused-field warnings

    public All_shapes(int x, int y)
    {
        super(x, y);
    }

    /* Draw all the shapes
     *
     * @param g The Graphics for the JPanel
     *
    @Override
    public void draw(Graphics g)
    {
        g.setColor(new Color(190/255f, 209/255f, 231/255f, 1.0f));
        g.fillRect(0, 0, 1720, 1060);

        int cx = 860;
        int cy = 420;

        g.setColor(new Color(137/255f, 188/255f, 250/255f, 1.0f));
        g.fillRoundRect(cx - 300, cy - 20, 600, 40, 20, 20);
        g.setColor(Color.cyan);
        g.drawRoundRect(cx - 300, cy - 20, 600, 40, 20, 20);

        g.setColor(new Color(255/255f, 240/255f, 245/245f, 0.5f));
        g.fillRoundRect(cx - 40, cy - 160, 80, 320, 40, 40);
        g.setColor(Color.magenta);
        g.drawRoundRect(cx - 40, cy - 160, 80, 320, 40, 40);

        int cw = 50;
        int ch = 50;
        int cr = 12;
        g.setColor(new Color(220/255f, 240/255f, 255/255f, 1.0f));
        g.fillRoundRect(cx - cw/2, cy - 150, cw, ch, cr, cr);
        g.setColor(Color.black);
        g.drawRoundRect(cx - cw/2, cy - 150, cw, ch, cr, cr);

        int pad = 6;
        int paneW = (cw - 3*pad) / 2;
        int paneH = ch - 2*pad;
        int leftX = cx - cw/2 + pad;
        int rightX = leftX + paneW + pad;
        int paneY = cy - 150 + pad;
        g.setColor(new Color(200/255f, 225/255f, 255/255f, 1.0f));
        g.fillRoundRect(leftX, paneY, paneW, paneH, 6, 6);
        g.fillRoundRect(rightX, paneY, paneW, paneH, 6, 6);
        g.setColor(new Color(100/255f, 120/255f, 140/255f, 1.0f));
        g.drawRoundRect(leftX, paneY, paneW, paneH, 6, 6);
        g.drawRoundRect(rightX, paneY, paneW, paneH, 6, 6);

        g.setColor(new Color(100/255f, 100/255f, 100/255f, 1.0f));
        g.fillOval(cx - 220, cy + 10, 80, 80);
        g.fillOval(cx + 140, cy + 10, 80, 80);
        g.setColor(Color.black);
        g.drawOval(cx - 220, cy + 10, 80, 80);
        g.drawOval(cx + 140, cy + 10, 80, 80);

        int[] px = new int[]{cx - 30, cx + 30, cx};
        int[] py = new int[]{cy - 160, cy - 160, cy - 200};
        g.setColor(new Color(180/255f, 180/255f, 180/255f, 1.0f));
        g.fillPolygon(px, py, 3);
        g.setColor(Color.black);
        g.drawPolygon(px, py, 3);

        g.setColor(new Color(80/255f, 80/255f, 80/255f, 1.0f));
        g.fillRect(cx - 5, cy + 170, 10, 30);
        g.setColor(Color.black);
        g.drawRect(cx - 5, cy + 170, 10, 30);
    }
}

public class Lab10
{
    public static void main(String[] args)
    {
        Picture pic = new Picture(2560, 1440);

        // ##### Here you should add objects to your picture using pic.addObject() ##### //
        //If you have a rectangle class, an example would be:
        pic.addObject(new All_shapes(0, 0));

        pic.showCanvas();
        pic.paint();
    }
}
 */