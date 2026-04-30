using System.Linq;
using System.Windows;
using System.Windows.Controls;
using CookBook.ApplicationData;

namespace CookBook.Pages
{
    public partial class FavoritesPage : Page
    {
        public FavoritesPage(){ InitializeComponent(); LoadFav(); }
        private void LoadFav(){ var ids=AppConnect.model01.LikeRecipes.Where(x=>x.idAuthor==AppConnect.AuthorID).Select(x=>x.idRecipes).ToList(); lvFav.ItemsSource=AppConnect.model01.Recipes.Where(x=>ids.Contains(x.RecipeID)).ToList(); }
        private void Del_Click(object s,RoutedEventArgs e){ if(lvFav.SelectedItem is Recipes r){ var rec=AppConnect.model01.LikeRecipes.FirstOrDefault(x=>x.idAuthor==AppConnect.AuthorID&&x.idRecipes==r.RecipeID); if(rec==null)return; AppConnect.model01.LikeRecipes.Remove(rec); AppConnect.model01.SaveChanges(); LoadFav(); }}
        private void Back_Click(object s,RoutedEventArgs e)=>NavigationService?.Navigate(new RecipesPage());
    }
}
