import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController dateTimeCtrl = TextEditingController();
  DateTime? date;
  TimeOfDay? timeOfDay;
  int categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add task",
          style: kTextStyle(30, isBold: true),
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
                  style: kTextStyle(25, isBold: true),
                ),
                TextField(
                  controller: tasknameCtrl,
                  decoration: InputDecoration(
                    hintText: "Task",
                    hintStyle: kTextStyle(18, color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
                spaceY(20),
                Text(
                  "Category",
                  style: kTextStyle(25, isBold: true),
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    ...taskCategories.map(
                      (category) => ChoiceChip(
                        selectedColor: AppColors.primaryColor,
                        label: Text(
                          category,
                          style: kTextStyle(14,
                              color: taskCategories.indexOf(category) ==
                                      categoryIndex
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        selected:
                            taskCategories.indexOf(category) == categoryIndex,
                        onSelected: (_) {
                          setState(() {
                            categoryIndex = taskCategories.indexOf(category);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                spaceY(20),
                Text(
                  "Date and Time",
                  style: kTextStyle(25, isBold: true),
                ),
                TextField(
                  controller: dateTimeCtrl,
                  decoration: InputDecoration(
                    hintText: "Select date and time",
                    hintStyle: kTextStyle(18, color: Colors.grey),
                    suffixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(),
                  ),
                  enabled: true,
                  readOnly: true,
                  onTap: () async {
                    date = await showDatePicker(
                      context: context,
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
                        DateTime dateTime = DateTime(date!.year, date!.month,
                            date!.day, timeOfDay!.hour, timeOfDay!.minute);
                        setState(() {
                          dateTimeCtrl.text =
                              "${DateFormat('d/M/y').format(dateTime)} - ${DateFormat.Hm().format(dateTime)}";
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
              onPressed: () {},
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
