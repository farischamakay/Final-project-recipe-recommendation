class Category {
  String urlPath;
  String categoryName;

  Category({required this.urlPath, required this.categoryName});
}

final List<Category> items = [
  Category(urlPath: 'assets/appetizer.png', categoryName: 'Appetizer'),
  Category(urlPath: 'assets/brunch.png', categoryName: 'Brunch'),
  Category(urlPath: 'assets/dessert.png', categoryName: 'Dessert'),
  Category(urlPath: 'assets/dinner.png', categoryName: 'Dinner'),
  Category(
      urlPath: 'assets/indian_breakfast.png', categoryName: 'Indian Breakfast'),
  Category(urlPath: 'assets/lunch.png', categoryName: 'Lunch'),
  Category(
      urlPath: 'assets/north_indian_breakfast.png',
      categoryName: 'North Indian Breakfast'),
  Category(urlPath: 'assets/one_pot_dish.png', categoryName: 'One Pot Dish'),
  Category(urlPath: 'assets/side_dish.png', categoryName: 'Side Dish'),
  Category(urlPath: 'assets/snack.png', categoryName: 'Snack'),
  Category(
      urlPath: 'assets/south_indian_breakfast.png',
      categoryName: 'South Indian Breakfast'),
  Category(
      urlPath: 'assets/world_breakfast.png', categoryName: 'World Breakfast'),
];
