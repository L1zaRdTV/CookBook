using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using CookBook.ApplicationData;

namespace CookBook.Pages
{
    public partial class PageLike : Page
    {
        private List<Recipes> recipes;

        public PageLike()
        {
            InitializeComponent();
            UpdateLikeRecipes();
        }

        private void UpdateLikeRecipes()
        {
            try
            {
                var likeRecipes = AppConnect.model01.LikeRecipes
                    .Where(x => x.idAuthor == AppConnect.AuthorID)
                    .Select(x => x.idRecipes)
                    .ToList();

                recipes = AppConnect.model01.Recipes
                    .Where(x => likeRecipes.Contains(x.RecipeID))
                    .ToList();

                foreach (var recipe in recipes)
                {
                    recipe.CategoryDisplay = AppConnect.model01.Categories
                        .FirstOrDefault(c => c.CategoryID == recipe.CategoryID)?.CategoryName ?? string.Empty;
                }

                listProducts.ItemsSource = recipes;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки избранных рецептов: " + ex.Message);
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            var result = MessageBox.Show("Вы действительно хотите удалить рецепт из избранного?",
                "Удаление", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                var button = sender as Button;
                var recipe = button?.DataContext as Recipes;
                if (recipe == null)
                {
                    return;
                }

                try
                {
                    var itemToRemove = AppConnect.model01.LikeRecipes
                        .FirstOrDefault(r => r.idRecipes == recipe.RecipeID
                                          && AppConnect.AuthorID == r.idAuthor);

                    if (itemToRemove == null)
                    {
                        MessageBox.Show("Рецепт не найден в избранном.");
                        return;
                    }

                    AppConnect.model01.LikeRecipes.Remove(itemToRemove);
                    AppConnect.model01.SaveChanges();

                    UpdateLikeRecipes();
                    MessageBox.Show("Рецепт удален из избранного!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка удаления из избранного: " + ex.Message);
                }
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new RecipesPage());
        }
    }
}
