using System;
using System.Drawing;
using System.Windows.Forms;

class BlackCover : Form
{
    public BlackCover()
    {
        BackColor = Color.Black;
        FormBorderStyle = FormBorderStyle.None;
        WindowState = FormWindowState.Maximized;
        TopMost = true;
        ShowInTaskbar = false;
        Cursor.Hide();
    }

    [STAThread]
    static void Main()
    {
        Application.EnableVisualStyles();
        Application.Run(new BlackCover());
    }
}