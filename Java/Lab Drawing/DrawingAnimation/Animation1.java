import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import javax.swing.*;

class Picture extends JPanel
{
    private final int canvasWidth = 1720;
    private final int canvasHeight = 1060;
    private final ArrayList<GraphicsObject> objects;

    public Picture()
    {
        this.objects = new ArrayList<>();
        setPreferredSize(new Dimension(canvasWidth, canvasHeight));
        setBackground(new Color(190, 209, 231));
    }

    public void addObject(GraphicsObject obj)
    {
        this.objects.add(obj);
    }

    @Override
    protected void paintComponent(Graphics g)
    {
        super.paintComponent(g);
        for (GraphicsObject obj : objects)
        {
            obj.draw(g);
        }
    }

    public void startAnimation()
    {
        repaint();
    }
}

abstract class GraphicsObject
{
    protected int x, y;

    public GraphicsObject(int x, int y)
    {
        this.x = x;
        this.y = y;
    }

    public void setPosition(int x, int y)
    {
        this.x = x;
        this.y = y;
    }

    public abstract void draw(Graphics g);
}

class Airplane extends GraphicsObject
{
    private final int centerX = 860;
    private final int baseY;
    public Airplane(int startY)
    {
        super(860, startY);
        this.baseY = startY;
    }

    @Override
    public void draw(Graphics g)
    {
        int cx = x;
        int cy = y;

        g.setColor(new Color(137, 188, 250));
        g.fillRoundRect(cx - 300, cy - 20, 600, 40, 20, 20);
        g.setColor(Color.cyan.darker());
        g.drawRoundRect(cx - 300, cy - 20, 600, 40, 20, 20);

        g.setColor(new Color(255, 240, 245, 180));
        g.fillRoundRect(cx - 40, cy - 160, 80, 320, 40, 40);
        g.setColor(Color.magenta.darker());
        g.drawRoundRect(cx - 40, cy - 160, 80, 320, 40, 40);

        int cw = 50, ch = 50, cr = 12;
        g.setColor(new Color(220, 240, 255));
        g.fillRoundRect(cx - cw/2, cy - 150, cw, ch, cr, cr);
        g.setColor(Color.black);
        g.drawRoundRect(cx - cw/2, cy - 150, cw, ch, cr, cr);

        int pad = 6;
        int paneW = (cw - 3*pad) / 2;
        int paneH = ch - 2*pad;
        int leftX = cx - cw/2 + pad;
        int rightX = leftX + paneW + pad;
        int paneY = cy - 150 + pad;

        g.setColor(new Color(200, 225, 255));
        g.fillRoundRect(leftX, paneY, paneW, paneH, 6, 6);
        g.fillRoundRect(rightX, paneY, paneW, paneH, 6, 6);
        g.setColor(new Color(100, 120, 140));
        g.drawRoundRect(leftX, paneY, paneW, paneH, 6, 6);
        g.drawRoundRect(rightX, paneY, paneW, paneH, 6, 6);

        g.setColor(new Color(100, 100, 100));
        g.fillOval(cx - 220, cy + 10, 80, 80);
        g.fillOval(cx + 140, cy + 10, 80, 80);
        g.setColor(Color.black);
        g.drawOval(cx - 220, cy + 10, 80, 80);
        g.drawOval(cx + 140, cy + 10, 80, 80);

        int[] px = {cx - 30, cx + 30, cx};
        int[] py = {cy - 160, cy - 160, cy - 200};
        g.setColor(new Color(180, 180, 180));
        g.fillPolygon(px, py, 3);
        g.setColor(Color.black);
        g.drawPolygon(px, py, 3);

        g.setColor(new Color(80, 80, 80));
        g.fillRect(cx - 5, cy + 170, 10, 30);
        g.setColor(Color.black);
        g.drawRect(cx - 5, cy + 170, 10, 30);
    }
}

public class Animation1
{
    public static void main(String[] args)
    {
        SwingUtilities.invokeLater(() ->
        {
            JFrame frame = new JFrame("Flying Airplane Animation");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

            Picture pic = new Picture();

            Airplane plane = new Airplane(1060 + 300);
            pic.addObject(plane);

            frame.add(pic);
            frame.pack();
            frame.setLocationRelativeTo(null);
            frame.setVisible(true);

            Timer timer = new Timer(30, new ActionListener()
            {
                @Override
                public void actionPerformed(ActionEvent e)
                {
                    int currentY = plane.y;
                    if (currentY > -500)
                    {
                        plane.setPosition(860, currentY - 6);
                        pic.repaint();
                    }
                    else
                    {
                        ((Timer) e.getSource()).stop();
                        System.out.println("Airplane has flown away!");
                    }
                }
            });

            timer.start();
        });
    }
}