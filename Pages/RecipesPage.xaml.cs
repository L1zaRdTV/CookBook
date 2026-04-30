using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using CookBook.ApplicationData;

namespace CookBook.Pages
{
    public partial class RecipesPage : Page
    {
        private List<Recipes> _recipes = new List<Recipes>();
        public RecipesPage() { InitializeComponent(); LoadFilters(); ApplyFilters(); }
        private void LoadFilters(){ cmbCategory.ItemsSource = new List<string>{"Все категории"}.Concat(AppConnect.model01.Categories.Select(x=>x.CategoryName).ToList()); cmbCategory.SelectedIndex=0; cmbSort.ItemsSource=new[]{"Без сортировки","По возрастанию времени","По убыванию времени"}; cmbSort.SelectedIndex=0; }
        private Recipes[] GetFilteredRecipes(){
            var query=AppConnect.model01.Recipes.ToList();
            foreach(var r in query){ var cat=AppConnect.model01.Categories.FirstOrDefault(x=>x.CategoryID==r.CategoryID); r.CategoryDisplay=cat?.CategoryName??""; }
            if(cmbCategory.SelectedIndex>0) query=query.Where(x=>x.CategoryDisplay==(string)cmbCategory.SelectedItem).ToList();
            var s=(tbSearch.Text??"").ToLower(); if(!string.IsNullOrWhiteSpace(s)) query=query.Where(x=>(x.RecipeName??"").ToLower().Contains(s)||(x.Description??"").ToLower().Contains(s)||(x.CategoryDisplay??"").ToLower().Contains(s)).ToList();
            if(cmbSort.SelectedIndex==1) query=query.OrderBy(x=>x.CookingTime).ToList(); else if(cmbSort.SelectedIndex==2) query=query.OrderByDescending(x=>x.CookingTime).ToList();
            return query.ToArray(); }
        private void ApplyFilters(){ _recipes=GetFilteredRecipes().ToList(); lvRecipes.ItemsSource=_recipes; icRecipes.ItemsSource=_recipes; tbCount.Text=$"Найдено рецептов: {_recipes.Count}"; }
        private void Filters_Changed(object s, RoutedEventArgs e)=>ApplyFilters();
        private void Edit_Click(object s,RoutedEventArgs e){ var r=(s as FrameworkElement)?.Tag as Recipes; if(r!=null) NavigationService?.Navigate(new AddEditRecipePage(r)); }
        private void Fav_Click(object s,RoutedEventArgs e){ var r=(s as FrameworkElement)?.Tag as Recipes; if(r==null)return; AppConnect.model01.LikeRecipes.Add(new LikeRecipes{ idAuthor=AppConnect.AuthorID,idRecipes=r.RecipeID}); try{AppConnect.model01.SaveChanges();}catch{} }
        private void BtnAdd_Click(object s,RoutedEventArgs e)=>NavigationService?.Navigate(new AddEditRecipePage(new Recipes()));
        private void BtnFavPage_Click(object s,RoutedEventArgs e)=>NavigationService?.Navigate(new FavoritesPage());
        private void lvRecipes_MouseDoubleClick(object s,System.Windows.Input.MouseButtonEventArgs e){ if(lvRecipes.SelectedItem is Recipes r) NavigationService?.Navigate(new AddEditRecipePage(r)); }
        private void BtnList_Click(object s,RoutedEventArgs e){ lvRecipes.Visibility=Visibility.Visible; svTiles.Visibility=Visibility.Collapsed; }
        private void BtnTiles_Click(object s,RoutedEventArgs e){ lvRecipes.Visibility=Visibility.Collapsed; svTiles.Visibility=Visibility.Visible; }
    }
}
