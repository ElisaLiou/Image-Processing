using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Bezier {
    public partial class form1 : Form {
        private System.Drawing.Graphics buffer;
        private System.Drawing.Graphics g;
        private System.Drawing.Pen pen1 = new Pen(Color.Black, 2F);

        private List<Point> items;
        private List<Rectangle> area;

        private Bitmap test;
        private static int areaWidth = 10;
        private int activeRectangleIndex;
        public form1(){
            InitializeComponent();
            area = new List<Rectangle>();
            items = new List<Point>();
            test = new Bitmap(panel2.Width, panel2.Height);
            buffer = Graphics.FromImage(test);
            this.pointCount = 0;
            this.activeRectangleIndex = -1;
        }
        private void drawRect(float x, float y) {
            buffer.DrawRectangle(pen1, x, y, 5, 5);
        }
        private void drawLine(float x1, float y1, float x2, float y2) {
            buffer.DrawLine(pen1, x1, y1, x2, y2);
        }
        private void panel1_Paint(object sender, PaintEventArgs e) {
            e.Graphics.DrawImage(test, 0, 0);
        }
        private int pointCount;

        /*
         * To detect mouse click on the form, 
         * when the points on the form are less than 4, then when user click, draw a point
         * when the points already 4, draw the bezier curve on the form
         */
        private void panel1_MouseClick(object sender, MouseEventArgs e) {

            if (pointCount < 4) {
                drawRect(e.X, e.Y);
                items.Add(new Point(e.X, e.Y));
                area.Add(new Rectangle(items[pointCount].X, items[pointCount].Y, areaWidth, areaWidth));
                panel2.Refresh();
                pointCount++;
            }
            if (pointCount == 4) {
                recursiveBezier(items[0].X, items[0].Y, items[1].X, items[1].Y, items[2].X, items[2].Y, items[3].X, items[3].Y);
                panel2.Refresh();
            }
        }
        
        private void panel1_MouseDown(object sender, MouseEventArgs e) {
            Console.WriteLine("pointcount: " + pointCount);
            if (pointCount > 3) {
                for (int i = 0; i < area.Count(); i++) {
                    if (area[i].Contains(e.X, e.Y)) {
                        activeRectangleIndex = i;
                    }
                }
                Console.WriteLine("active point:" + activeRectangleIndex);
            }
        }

        private void panel1_MouseMove(object sender, MouseEventArgs e) {
            if (activeRectangleIndex != -1&&pointCount>3) {
                items[activeRectangleIndex] = new Point(e.X, e.Y);
                area[activeRectangleIndex] = new Rectangle(e.X, e.Y, areaWidth, areaWidth);
                buffer.Clear(panel2.BackColor);
                foreach(Point item in items){
                    drawRect(item.X, item.Y);
                }
                recursiveBezier(items[0].X, items[0].Y, items[1].X, items[1].Y, items[2].X, items[2].Y, items[3].X, items[3].Y);
                panel2.Refresh();
            }
        }

        private void panel1_MouseUp(object sender, MouseEventArgs e) {
            activeRectangleIndex = -1;
        }


        private void recursiveBezier(double X1, double Y1,
                                 double X2, double Y2,
                                 double X3, double Y3,
                                 double X4, double Y4) {

            // Find the mid-point from each point drawn on the surface
            double X12 = (X1 + X2) / 2;         double Y12 = (Y1 + Y2) / 2;
            double X23 = (X2 + X3) / 2;         double Y23 = (Y2 + Y3) / 2;
            double X34 = (X3 + X4) / 2;         double Y34 = (Y3 + Y4) / 2;

            // Find the mid-point of the points above
            double X123 = (X12 + X23) / 2;      double Y123 = (Y12 + Y23) / 2;
            double X234 = (X23 + X34) / 2;      double Y234 = (Y23 + Y34) / 2;

            // The final mid-point (from 2 points above
            double X1234 = (X123 + X234) / 2;   double Y1234 = (Y123 + Y234) / 2;


            double d2 = Math.Abs((X4 - X1) * (Y1 - Y2) - (X1 - X2) * (Y4 - Y1)) /
                    Math.Sqrt((X4 - X1) * (X4 - X1) + (Y4 - Y1) * (Y4 - Y1));
            double d3 = Math.Abs((X4 - X1) * (Y1 - Y3) - (X1 - X3) * (Y4 - Y1)) /
                    Math.Sqrt((X4 - X1) * (X4 - X1) + (Y4 - Y1) * (Y4 - Y1));
            if (d2 <= 0.5 && d3 <= 0.5) {
                drawLine((float)X1, (float)Y1, (float)X4, (float)Y4);
            }
            else {
                //left recursion
                recursiveBezier(X1, Y1, X12, Y12, X123, Y123, X1234, Y1234);
                
                //right recursion
                recursiveBezier(X1234, Y1234, X234, Y234, X34, Y34, X4, Y4);
            }
        }
       
    }
}
