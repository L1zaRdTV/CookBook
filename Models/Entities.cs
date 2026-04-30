using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;

namespace CookBook
{
    public class CulinaryBookEntities : DbContext
    {
        public CulinaryBookEntities() : base("name=CulinaryBookEntities") { }

        public DbSet<Authors> Authors { get; set; }
        public DbSet<Categories> Categories { get; set; }
        public DbSet<Recipes> Recipes { get; set; }
        public DbSet<RecipeImages> RecipeImages { get; set; }
        public DbSet<CookingSteps> CookingSteps { get; set; }
        public DbSet<LikeRecipes> LikeRecipes { get; set; }
        public DbSet<Ingredients> Ingredients { get; set; }
        public DbSet<RecipeIngredients> RecipeIngredients { get; set; }
    }

    public class Authors { [Key] public int AuthorID { get; set; } public string AuthorName { get; set; } public string Login { get; set; } public string Password { get; set; } public DateTime? BirthDay { get; set; } public float? Stage { get; set; } public string Mail { get; set; } public string Number { get; set; } }
    public class Categories { [Key] public int CategoryID { get; set; } public string CategoryName { get; set; } }
    public class Recipes { [Key] public int RecipeID { get; set; } public string RecipeName { get; set; } public string Description { get; set; } public int? CategoryID { get; set; } public int? AuthorID { get; set; } public int? CookingTime { get; set; } public string Image { get; set; } [NotMapped] public string CategoryDisplay { get; set; } }
    public class RecipeImages { [Key] public int ImageID { get; set; } public int RecipeID { get; set; } public string ImagePath { get; set; } }
    public class CookingSteps { [Key] public int StepID { get; set; } public int RecipeID { get; set; } public int StepNumber { get; set; } public string StepDescription { get; set; } }
    public class LikeRecipes { [Key] public int id { get; set; } public int idAuthor { get; set; } public int idRecipes { get; set; } }
    public class Ingredients { [Key] public int IngredientID { get; set; } public string IngredientName { get; set; } }
    public class RecipeIngredients { [Key] public int RecipeIngredientID { get; set; } public int RecipeID { get; set; } public int IngredientID { get; set; } public string Quantity { get; set; } }
}
