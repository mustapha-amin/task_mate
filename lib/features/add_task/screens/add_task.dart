import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_mate/features/home/screens/home.dart';
import 'package:task_mate/utils/colors.dart';
import 'package:task_mate/utils/extensions.dart';
import 'package:task_mate/utils/textstyle.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController tasknameCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

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
      body: SizedBox(
        child: Column(
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text(
                    "Category",
                    style: kTextStyle(25, isBold: true),
                  ),
                  Text(
                    "Date",
                    style: kTextStyle(25, isBold: true),
                  ),
                  // TextField(
                  //   controller: timeCtrl,
                  //   enabled: true,
                  //   readOnly: true,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     suffix: InkWell(
                  //       onTap: () async {
                  //         DateTime? pickedDate = await showDatePicker(
                  //           context: context,
                  //           firstDate: DateTime.now(),
                  //           lastDate: DateTime(2099),
                  //         );
                  //         setState(() {
                  //           dateCtrl.text = pickedDate.toString();
                  //         });
                  //       },
                  //       child: Icon(
                  //         Icons.calendar_month,
                  //         color: Colors.blue,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                 
                  Text("Description", style: kTextStyle(25, isBold: true)),
                  TextField(
                    controller: descriptionCtrl,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
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
        ),
      ).padX(25),
    );
  }
}
