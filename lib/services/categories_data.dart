import 'package:news_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel(categoryName: 'Business', image: 'images/business.jpeg');
  category.add(categoryModel);
  categoryModel = CategoryModel(categoryName: 'Entertainment', image: 'images/entertainment.jpg');
  category.add(categoryModel);
  categoryModel = CategoryModel(categoryName: 'General', image: 'images/general.jpg');
  category.add(categoryModel);
  categoryModel = CategoryModel(categoryName: 'Health', image: 'images/health.jpeg');
  category.add(categoryModel);
  categoryModel = CategoryModel(categoryName: 'Sports', image: 'images/sports.jpg');
  category.add(categoryModel);
  return category;
}