import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/providers/tasks_provider.dart';
import 'package:task_mate/utils/colors.dart';
import 'package:task_mate/utils/extensions.dart';
import 'package:task_mate/utils/textstyle.dart';

import '../../../shared/spacing.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    List<TaskModel> todaysTasks = tasksProvider.tasks
        .where((tasks) => tasks.dateTime!.isSameDayAs(DateTime.now()))
        .toList();

    List<TaskModel> completedTasks =
        todaysTasks.where((task) => task.completed == true).toList();
    return Column(
      children: [
        spaceY(10),
        Container(
          width: double.infinity,
          height: 25.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            gradient: LinearGradient(colors: [
              Colors.blue[300]!,
              Colors.blue[900]!,
            ]),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's progress summary",
                    style: kTextStyle(22, color: Colors.white, isBold: true),
                  ),
                  spaceY(10),
                  Text(
                    todaysTasks.length == 1
                        ? "${todaysTasks.length} task"
                        : "${todaysTasks.length} tasks",
                    style: kTextStyle(20, color: Colors.white),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (todaysTasks.isNotEmpty)
                    Text(
                      "${((completedTasks.length / todaysTasks.length) * 100).round()}%",
                      style: kTextStyle(18, color: Colors.white),
                    ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                        begin: 0,
                        end: (todaysTasks
                                .where((task) => task.completed == true)
                                .length /
                            todaysTasks.length)),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, progress, _) {
                      return LinearProgressIndicator(
                        value: todaysTasks.isEmpty ? 0 : progress,
                        minHeight: 7,
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: Colors.blueGrey[300],
                        color: Colors.white,
                      );
                    },
                  )
                ],
              )
            ],
          ).padX(25).padY(8),
        ),
        spaceY(30),
      ],
    );
  }
}
