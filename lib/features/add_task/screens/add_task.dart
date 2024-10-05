import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:task_mate/features/add_task/screens/edit_categories.dart';
import 'package:task_mate/models/category_model.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/providers/categories_provider.dart';
import 'package:task_mate/providers/tasks_provider.dart';
import 'package:task_mate/services/notifications_service.dart';
import 'package:task_mate/shared/spacing.dart';
import 'package:task_mate/utils/colors.dart';
import 'package:task_mate/utils/default_categories.dart';
import 'package:task_mate/utils/extensions.dart';
import 'package:task_mate/utils/textstyle.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController tasknameCtrl = TextEditingController();
  TextEditingController dateTimeCtrl = TextEditingController();
  DateTime? date;
  TimeOfDay? timeOfDay;
  DateTime? dateTime;
  String selectedCategory = "School";

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    CategoriesProvider categoriesProvider =
        Provider.of<CategoriesProvider>(context);
    List<CategoryModel> categories = [
      ...taskCategories,
      ...categoriesProvider.categories
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add task",
          style: kTextStyle(23, isBold: true),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Name",
                  style: kTextStyle(21, isBold: true),
                ),
                TextField(
                  controller: tasknameCtrl,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Task",
                    hintStyle: kTextStyle(18, color: Colors.grey),
                    border: const OutlineInputBorder(),
                  ),
                ),
                spaceY(20),
                Text(
                  "Category",
                  style: kTextStyle(21, isBold: true),
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    ...categories.map(
                      (category) => ChoiceChip(
                        selectedColor: AppColors.primaryColor,
                        label: Text(
                          category.category!,
                          style: kTextStyle(14,
                              color: category.category == selectedCategory
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        selected: category.category == selectedCategory,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = category.category!;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditCategories(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                spaceY(20),
                Text(
                  "Date and Time",
                  style: kTextStyle(21, isBold: true),
                ),
                TextField(
                  controller: dateTimeCtrl,
                  decoration: InputDecoration(
                    hintText: "Select date and time",
                    hintStyle: kTextStyle(18, color: Colors.grey),
                    suffixIcon: const Icon(Icons.calendar_month),
                    border: const OutlineInputBorder(),
                  ),
                  enabled: true,
                  readOnly: true,
                  onTap: () async {
                    date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2099),
                    );
                    if (date != null) {
                      timeOfDay = await showTimePicker(
                          // ignore: use_build_context_synchronously
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: false),
                                child: child!);
                          });
                      if (timeOfDay != null) {
                        dateTime = DateTime(date!.year, date!.month, date!.day,
                            timeOfDay!.hour, timeOfDay!.minute);
                        setState(() {
                          dateTimeCtrl.text =
                              "${DateFormat('d/M/y').format(dateTime!)} - ${DateFormat.Hm().format(dateTime!)}";
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: 100.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                if (tasknameCtrl.text.isNotEmpty && dateTime != null) {
                  try {
                    tasksProvider.addTask(TaskModel(
                      task: tasknameCtrl.text,
                      dateTime: dateTime!,
                      completed: false,
                      category: selectedCategory,
                    ));
                    await NotificationService.scheduleTaskNotification(
                      dateTime.hashCode,
                      tasknameCtrl.text.trim(),
                      "You have a task to complete",
                      dateTime!,
                    );
                  } catch (e) {
                    log(e.toString());
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Task created"),
                      margin: EdgeInsets.all(5),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Fill the required fields"),
                      margin: EdgeInsets.all(5),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                }
              },
              child: Text(
                "Create task",
                style: kTextStyle(20, color: Colors.white),
              ),
            ),
          ).padY(10),
        ],
      ).padX(25),
    );
  }
}
