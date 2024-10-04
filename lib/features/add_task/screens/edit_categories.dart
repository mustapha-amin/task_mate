import 'package:flutter/material.dart';
import 'package:task_mate/features/add_task/screens/add_task.dart';
import 'package:task_mate/utils/default_categories.dart';
import 'package:task_mate/utils/extensions.dart';
import 'package:task_mate/utils/textstyle.dart';

class EditCategories extends StatelessWidget {
  const EditCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit categories",
          style: kTextStyle(22, isBold: true),
        ),
        actions: [
          IconButton.outlined(
            onPressed: () {},
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
                  category,
                  style: kTextStyle(18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
