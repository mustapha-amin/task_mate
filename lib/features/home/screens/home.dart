import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/features/home/widgets/progress_widget.dart';
import 'package:task_mate/features/home/widgets/task_tile.dart';
import 'package:task_mate/providers/tasks_provider.dart';
import 'package:task_mate/shared/spacing.dart';
import 'package:task_mate/utils/extensions.dart';

import '../../../models/task_model.dart';
import '../../../utils/textstyle.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    List<TaskModel> todaysTasks = tasksProvider.tasks
        .where((tasks) => tasks.dateTime!.isSameDayAs(DateTime.now()))
        .toList();

    List<TaskModel> completedTasks =
        todaysTasks.where((task) => task.completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: kTextStyle(23, isBold: true),
        ).padX(10),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressWidget(),
            if (todaysTasks.isNotEmpty)
              ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Today's tasks",
                  style: kTextStyle(22, isBold: true),
                ),
                children: [
                  ...todaysTasks
                      .where((task) => task.completed != true)
                      .map((task) => TaskTile(
                            taskModel: task,
                            isHomeScreen: true,
                          )),
                ],
              ),
            spaceY(5),
            if (todaysTasks.isNotEmpty)
              if (todaysTasks
                  .where((task) => task.completed == true)
                  .isNotEmpty)
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    "Completed today",
                    style: kTextStyle(22, isBold: true),
                  ),
                  children: [
                    ...completedTasks.map((tasks) => TaskTile(
                          taskModel: tasks,
                          isHomeScreen: true,
                        )),
                  ],
                )
          ],
        ).padX(20),
      ),
    );
  }
}
