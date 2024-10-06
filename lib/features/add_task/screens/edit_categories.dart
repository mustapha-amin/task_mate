import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/models/category_model.dart';
import 'package:task_mate/providers/categories_provider.dart';
import 'package:task_mate/utils/default_categories.dart';
import 'package:task_mate/utils/extensions.dart';
import 'package:task_mate/utils/textstyle.dart';

class EditCategories extends StatefulWidget {
  const EditCategories({super.key});

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  TextEditingController categoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoriesProvider categoriesProvider =
        Provider.of<CategoriesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit categories",
          style: kTextStyle(22, isBold: true),
        ),
        actions: [
          IconButton.outlined(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add category"),
                      content: TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (categoryController.text.isNotEmpty) {
                              categoriesProvider.addCategory(
                                CategoryModel(
                                  category: categoryController.text.trim(),
                                  id: DateTime.timestamp().toString(),
                                ),
                              );
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Add",
                            style: kTextStyle(18),
                          ),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.add),
            iconSize: 28,
          ).padX(5),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...taskCategories.map(
              (category) => ListTile(
                title: Text(
                  category.category!,
                  style: kTextStyle(18),
                ),
              ),
            ),
            if (categoriesProvider.categories.isNotEmpty)
              ...categoriesProvider.categories.map(
                (category) => ListTile(
                  title: Text(
                    category.category!,
                    style: kTextStyle(18),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Delete category",
                              style: kTextStyle(22),
                            ),
                            content: Text(
                              "Do you want to delete this category?",
                              style: kTextStyle(16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  categoriesProvider.deleteCategory(
                                    category.id!,
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Yes",
                                  style: kTextStyle(16, color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "No",
                                  style: kTextStyle(16),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
