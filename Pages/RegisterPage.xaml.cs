using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using CookBook.ApplicationData;

namespace CookBook.Pages
{
    public partial class RegisterPage : Page
    {
        public RegisterPage() { InitializeComponent(); }
        private void BtnReg_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(tbName.Text) || string.IsNullOrWhiteSpace(tbLogin.Text) || string.IsNullOrWhiteSpace(pbPass.Password)) { MessageBox.Show("Заполните обязательные поля"); return; }
            if (AppConnect.model01.Authors.FirstOrDefault(x => x.Login == tbLogin.Text) != null) { MessageBox.Show("Логин занят"); return; }
            if (pbPass.Password != pbPass2.Password) { MessageBox.Show("Пароли не совпадают"); return; }
            if (!float.TryParse(tbStage.Text, out var stage) || stage < 0) { MessageBox.Show("Стаж некорректен"); return; }
            if (dpBirth.SelectedDate == null || dpBirth.SelectedDate > DateTime.Now.AddYears(-14)) { MessageBox.Show("Возраст должен быть 14+"); return; }
            AppConnect.model01.Authors.Add(new Authors { AuthorName = tbName.Text, BirthDay = dpBirth.SelectedDate, Stage = stage, Login = tbLogin.Text, Password = pbPass.Password, Mail = tbMail.Text, Number = tbPhone.Text });
            try { AppConnect.model01.SaveChanges(); NavigationService?.Navigate(new LoginPage()); } catch (Exception ex) { MessageBox.Show(ex.Message); }
        }
    }
}
