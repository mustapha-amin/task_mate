import 'package:flutter/material.dart';
import 'package:task_mate/models/category_model.dart';
import 'package:task_mate/services/categories_db.dart';

class CategoriesProvider extends ChangeNotifier {
  final CategoriesDB categoriesDB;
  List<CategoryModel> categories = [];

  CategoriesProvider({required this.categoriesDB}) {
    fetchCategories();
  }

  void fetchCategories() {
    categories = categoriesDB.fetchCategories();
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel category) async {
    await categoriesDB.addCategory(category);
    fetchCategories();
  }

  Future<void> deleteCategory(String id) async {
    await categoriesDB.deleteCategory(id);
    fetchCategories();
  }
}
