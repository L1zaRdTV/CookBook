using System.Windows;
using CookBook.ApplicationData;
using CookBook.Pages;

namespace CookBook
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            AppConnect.model01 = new CulinaryBookEntities();
            AppFrame.frmMain = FrmMain;
            FrmMain.Navigate(new LoginPage());
        }
    }
}
