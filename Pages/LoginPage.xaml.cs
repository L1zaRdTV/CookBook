using System.Linq;
using System.Windows;
using System.Windows.Controls;
using CookBook.ApplicationData;

namespace CookBook.Pages
{
    public partial class LoginPage : Page
    {
        public LoginPage() { InitializeComponent(); }
        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            var user = AppConnect.model01.Authors.FirstOrDefault(x => x.Login == tbLogin.Text && x.Password == pbPassword.Password);
            if (user == null) { MessageBox.Show("Неверный логин/пароль"); return; }
            AppConnect.AuthorID = user.AuthorID;
            NavigationService?.Navigate(new RecipesPage());
        }
        private void BtnRegister_Click(object sender, RoutedEventArgs e) => NavigationService?.Navigate(new RegisterPage());
    }
}
