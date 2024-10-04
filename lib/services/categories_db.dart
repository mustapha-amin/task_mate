import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_mate/models/category_model.dart';

class CategoriesDB {
  Box<CategoryModel> tasksBox;

  CategoriesDB({required this.tasksBox});

  Future<void> addCategory(CategoryModel category) async {
    await tasksBox.put(category.id, category);
  }

  Future<void> deleteCategory(String? id) async {
    await tasksBox.delete(id);
  }

  List<CategoryModel> fetchCategories() {
    return tasksBox.values.toList();
  }
}
