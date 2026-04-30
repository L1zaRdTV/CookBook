CREATE DATABASE CulinaryBookDB;
GO
USE CulinaryBookDB;
GO
CREATE TABLE Authors (
    AuthorID INT IDENTITY PRIMARY KEY,
    AuthorName NVARCHAR(150) NOT NULL,
    Login NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    BirthDay DATE NULL,
    Stage FLOAT NULL,
    Mail NVARCHAR(100) NULL,
    Number NVARCHAR(30) NULL
);
CREATE TABLE Categories (CategoryID INT IDENTITY PRIMARY KEY, CategoryName NVARCHAR(100) NOT NULL);
CREATE TABLE Recipes (
    RecipeID INT IDENTITY PRIMARY KEY,
    RecipeName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CategoryID INT NULL FOREIGN KEY REFERENCES Categories(CategoryID),
    AuthorID INT NULL FOREIGN KEY REFERENCES Authors(AuthorID),
    CookingTime INT NULL,
    Image NVARCHAR(50) NULL
);
CREATE TABLE RecipeImages (ImageID INT IDENTITY PRIMARY KEY, RecipeID INT NOT NULL FOREIGN KEY REFERENCES Recipes(RecipeID) ON DELETE CASCADE, ImagePath NVARCHAR(255) NOT NULL);
CREATE TABLE CookingSteps (StepID INT IDENTITY PRIMARY KEY, RecipeID INT NOT NULL FOREIGN KEY REFERENCES Recipes(RecipeID) ON DELETE CASCADE, StepNumber INT NOT NULL, StepDescription NVARCHAR(MAX) NOT NULL);
CREATE TABLE LikeRecipes (id INT IDENTITY PRIMARY KEY, idAuthor INT NOT NULL FOREIGN KEY REFERENCES Authors(AuthorID) ON DELETE CASCADE, idRecipes INT NOT NULL FOREIGN KEY REFERENCES Recipes(RecipeID) ON DELETE CASCADE);
CREATE TABLE Ingredients (IngredientID INT IDENTITY PRIMARY KEY, IngredientName NVARCHAR(150) NOT NULL);
CREATE TABLE RecipeIngredients (RecipeIngredientID INT IDENTITY PRIMARY KEY, RecipeID INT NOT NULL FOREIGN KEY REFERENCES Recipes(RecipeID) ON DELETE CASCADE, IngredientID INT NOT NULL FOREIGN KEY REFERENCES Ingredients(IngredientID), Quantity NVARCHAR(50) NULL);

-- Seed data
INSERT INTO Authors (AuthorName, Login, Password, BirthDay, Stage, Mail, Number) VALUES
(N'Анна Ковалева', N'anna.k', N'anna123', '1992-04-10', 6.5, N'anna.k@example.com', N'+7-900-100-10-10'),
(N'Илья Смирнов', N'ilya.s', N'ilya123', '1988-09-03', 9.0, N'ilya.s@example.com', N'+7-900-100-20-20'),
(N'Мария Петрова', N'maria.p', N'maria123', '1995-01-19', 4.0, N'maria.p@example.com', N'+7-900-100-30-30'),
(N'Сергей Орлов', N'sergey.o', N'sergey123', '1990-12-25', 7.0, N'sergey.o@example.com', N'+7-900-100-40-40'),
(N'Екатерина Белова', N'katya.b', N'katya123', '1998-07-07', 3.5, N'katya.b@example.com', N'+7-900-100-50-50');

INSERT INTO Categories (CategoryName) VALUES
(N'Завтраки'),
(N'Супы'),
(N'Салаты'),
(N'Основные блюда'),
(N'Гарниры'),
(N'Выпечка'),
(N'Десерты'),
(N'Напитки'),
(N'Закуски');

INSERT INTO Ingredients (IngredientName) VALUES
(N'Яйцо'),
(N'Молоко'),
(N'Мука'),
(N'Сахар'),
(N'Соль'),
(N'Черный перец'),
(N'Куриное филе'),
(N'Говядина'),
(N'Картофель'),
(N'Морковь'),
(N'Лук репчатый'),
(N'Чеснок'),
(N'Томат'),
(N'Огурец'),
(N'Сметана'),
(N'Сливочное масло'),
(N'Растительное масло'),
(N'Рис'),
(N'Гречка'),
(N'Паста'),
(N'Сыр твердый'),
(N'Моцарелла'),
(N'Шампиньоны'),
(N'Капуста'),
(N'Свекла'),
(N'Куриный бульон'),
(N'Паприка'),
(N'Базилик'),
(N'Петрушка'),
(N'Лимон'),
(N'Мед'),
(N'Какао'),
(N'Разрыхлитель'),
(N'Творог'),
(N'Банан'),
(N'Яблоко');

INSERT INTO Recipes (RecipeName, Description, CategoryID, AuthorID, CookingTime, Image) VALUES
(N'Омлет с сыром', N'Пышный омлет на сковороде с сыром и зеленью.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Завтраки'), (SELECT AuthorID FROM Authors WHERE Login = N'anna.k'), 15, N'omelet.jpg'),
(N'Борщ домашний', N'Классический борщ на говядине со сметаной.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Супы'), (SELECT AuthorID FROM Authors WHERE Login = N'ilya.s'), 90, N'borscht.jpg'),
(N'Цезарь с курицей', N'Салат с курицей, сыром и сухариками.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Салаты'), (SELECT AuthorID FROM Authors WHERE Login = N'maria.p'), 25, N'caesar.jpg'),
(N'Паста с грибами', N'Сливочная паста с шампиньонами и сыром.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Основные блюда'), (SELECT AuthorID FROM Authors WHERE Login = N'sergey.o'), 30, N'pasta.jpg'),
(N'Картофельное пюре', N'Нежное пюре на молоке и сливочном масле.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Гарниры'), (SELECT AuthorID FROM Authors WHERE Login = N'katya.b'), 35, N'mash.jpg'),
(N'Сырники', N'Творожные сырники с хрустящей корочкой.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Завтраки'), (SELECT AuthorID FROM Authors WHERE Login = N'anna.k'), 20, N'syrniki.jpg'),
(N'Шоколадный кекс', N'Влажный шоколадный кекс к чаю.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Выпечка'), (SELECT AuthorID FROM Authors WHERE Login = N'maria.p'), 55, N'cake.jpg'),
(N'Банановый смузи', N'Быстрый напиток из банана и молока.', (SELECT CategoryID FROM Categories WHERE CategoryName = N'Напитки'), (SELECT AuthorID FROM Authors WHERE Login = N'katya.b'), 10, N'smoothie.jpg');

INSERT INTO RecipeImages (RecipeID, ImagePath) VALUES
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром'), N'Images/omelet-1.jpg'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), N'Images/borscht-1.jpg'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Цезарь с курицей'), N'Images/caesar-1.jpg'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Паста с грибами'), N'Images/pasta-1.jpg'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Картофельное пюре'), N'Images/mash-1.jpg'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Сырники'), N'Images/syrniki-1.jpg'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Шоколадный кекс'), N'Images/cake-1.jpg'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Банановый смузи'), N'Images/smoothie-1.jpg');

INSERT INTO CookingSteps (RecipeID, StepNumber, StepDescription) VALUES
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром'), 1, N'Взбейте яйца с молоком и щепоткой соли.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром'), 2, N'Вылейте смесь на разогретую сковороду с маслом.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром'), 3, N'Добавьте тертый сыр и готовьте под крышкой 5 минут.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), 1, N'Сварите мясной бульон из говядины.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), 2, N'Добавьте картофель, капусту и зажарку из свеклы, моркови и лука.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), 3, N'Варите до готовности и подавайте со сметаной.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Цезарь с курицей'), 1, N'Обжарьте куриное филе с солью и перцем.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Цезарь с курицей'), 2, N'Смешайте листья салата, курицу, сыр и сухарики.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Цезарь с курицей'), 3, N'Заправьте соусом и подавайте.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Паста с грибами'), 1, N'Отварите пасту до состояния al dente.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Паста с грибами'), 2, N'Обжарьте лук и шампиньоны, добавьте сливки.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Паста с грибами'), 3, N'Смешайте пасту с соусом и посыпьте сыром.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Картофельное пюре'), 1, N'Отварите очищенный картофель до мягкости.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Картофельное пюре'), 2, N'Разомните картофель с горячим молоком и маслом.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Картофельное пюре'), 3, N'Посолите по вкусу и подавайте горячим.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Сырники'), 1, N'Смешайте творог, яйцо, сахар и немного муки.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Сырники'), 2, N'Сформируйте сырники и обваляйте в муке.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Сырники'), 3, N'Обжарьте с двух сторон до золотистого цвета.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Шоколадный кекс'), 1, N'Смешайте сухие ингредиенты: муку, какао, сахар, разрыхлитель.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Шоколадный кекс'), 2, N'Добавьте яйца, молоко и масло, перемешайте до однородности.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Шоколадный кекс'), 3, N'Выпекайте при 180°C около 35 минут.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Банановый смузи'), 1, N'Очистите банан и нарежьте кусочками.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Банановый смузи'), 2, N'Взбейте банан с молоком и ложкой меда.'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Банановый смузи'), 3, N'Подавайте сразу после приготовления.');

INSERT INTO RecipeIngredients (RecipeID, IngredientID, Quantity) VALUES
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Яйцо'), N'3 шт'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Молоко'), N'80 мл'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Сыр твердый'), N'60 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Говядина'), N'500 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Свекла'), N'2 шт'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Капуста'), N'300 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Картофель'), N'4 шт'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Цезарь с курицей'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Куриное филе'), N'250 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Цезарь с курицей'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Сыр твердый'), N'70 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Паста с грибами'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Паста'), N'250 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Паста с грибами'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Шампиньоны'), N'200 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Картофельное пюре'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Картофель'), N'700 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Картофельное пюре'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Сливочное масло'), N'40 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Сырники'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Творог'), N'400 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Сырники'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Яйцо'), N'1 шт'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Шоколадный кекс'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Мука'), N'220 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Шоколадный кекс'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Какао'), N'40 г'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Банановый смузи'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Банан'), N'1 шт'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Банановый смузи'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Молоко'), N'250 мл'),
((SELECT RecipeID FROM Recipes WHERE RecipeName = N'Банановый смузи'), (SELECT IngredientID FROM Ingredients WHERE IngredientName = N'Мед'), N'1 ч.л.');

INSERT INTO LikeRecipes (idAuthor, idRecipes) VALUES
((SELECT AuthorID FROM Authors WHERE Login = N'ilya.s'), (SELECT RecipeID FROM Recipes WHERE RecipeName = N'Омлет с сыром')),
((SELECT AuthorID FROM Authors WHERE Login = N'maria.p'), (SELECT RecipeID FROM Recipes WHERE RecipeName = N'Борщ домашний')),
((SELECT AuthorID FROM Authors WHERE Login = N'sergey.o'), (SELECT RecipeID FROM Recipes WHERE RecipeName = N'Цезарь с курицей')),
((SELECT AuthorID FROM Authors WHERE Login = N'katya.b'), (SELECT RecipeID FROM Recipes WHERE RecipeName = N'Паста с грибами')),
((SELECT AuthorID FROM Authors WHERE Login = N'anna.k'), (SELECT RecipeID FROM Recipes WHERE RecipeName = N'Сырники'));
