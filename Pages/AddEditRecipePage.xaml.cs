using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;
using CookBook.ApplicationData;

namespace CookBook.Pages
{
    public partial class AddEditRecipePage : Page
    {
        private readonly Recipes _recipe;
        private List<RecipeImages> _images = new List<RecipeImages>();
        private int _currentIndex = 0;
        public AddEditRecipePage(Recipes recipe){ InitializeComponent(); _recipe=recipe; DataContext=_recipe; cmbCategory.ItemsSource=AppConnect.model01.Categories.ToList(); cmbAuthor.ItemsSource=AppConnect.model01.Authors.ToList(); LoadImages(); }
        private void LoadImages(){ if(_recipe.RecipeID==0) return; _images=AppConnect.model01.RecipeImages.Where(x=>x.RecipeID==_recipe.RecipeID).ToList(); LoadImage(); }
        private void LoadImage(){ if(!_images.Any()) return; try{ var p=Path.Combine(AppDomain.CurrentDomain.BaseDirectory,"..\\..\\..\\Images",_images[_currentIndex].ImagePath??""); if(!File.Exists(p)) return; var bmp=new BitmapImage(); bmp.BeginInit(); bmp.CacheOption=BitmapCacheOption.OnLoad; bmp.UriSource=new Uri(p,UriKind.Absolute); bmp.EndInit(); bmp.Freeze(); PhotoImage.Source=bmp; recipeNamePhoto.Text=Path.GetFileName(p);} catch(Exception ex){MessageBox.Show(ex.Message);} }
        private void Prev_Click(object s,RoutedEventArgs e){ if(!_images.Any()) return; _currentIndex=(_currentIndex-1+_images.Count)%_images.Count; LoadImage(); }
        private void Next_Click(object s,RoutedEventArgs e){ if(!_images.Any()) return; _currentIndex=(_currentIndex+1)%_images.Count; LoadImage(); }
        private void Upload_Click(object s,RoutedEventArgs e){ var d=new OpenFileDialog{Filter="Images|*.png;*.jpg;*.jpeg"}; if(d.ShowDialog()!=true) return; try{ var dir=Path.Combine(AppDomain.CurrentDomain.BaseDirectory,"..\\..\\..\\Images"); Directory.CreateDirectory(dir); var name=Guid.NewGuid()+Path.GetExtension(d.FileName); File.Copy(d.FileName,Path.Combine(dir,name),true); _recipe.Image=name; if(_recipe.RecipeID>0){ AppConnect.model01.RecipeImages.Add(new RecipeImages{RecipeID=_recipe.RecipeID,ImagePath=name}); AppConnect.model01.SaveChanges(); LoadImages(); }}catch(Exception ex){MessageBox.Show(ex.Message);} }
        private void Save_Click(object s,RoutedEventArgs e){ if(string.IsNullOrWhiteSpace(_recipe.RecipeName)){MessageBox.Show("RecipeName обязателен"); return;} var c=cmbCategory.SelectedItem as Categories; var a=cmbAuthor.SelectedItem as Authors; _recipe.CategoryID=AppConnect.model01.Categories.FirstOrDefault(x=>x.CategoryName==c?.CategoryName)?.CategoryID; _recipe.AuthorID=AppConnect.model01.Authors.FirstOrDefault(x=>x.AuthorName==a?.AuthorName)?.AuthorID; try{ if(_recipe.RecipeID==0) AppConnect.model01.Recipes.Add(_recipe); AppConnect.model01.SaveChanges(); NavigationService?.Navigate(new RecipesPage()); } catch(Exception ex){ MessageBox.Show(ex.Message);} }
        private void Steps_Click(object s,RoutedEventArgs e){ NavigationService?.Navigate(new CookingStepsPage(_recipe)); }
    }
}
