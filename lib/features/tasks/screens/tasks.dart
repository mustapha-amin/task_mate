import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/features/home/widgets/task_tile.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/providers/tasks_provider.dart';
import 'package:task_mate/utils/colors.dart';
import 'package:task_mate/utils/extensions.dart';

import '../../../utils/textstyle.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: kTextStyle(25, isBold: true),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: kTextStyle(17),
          labelColor: AppColors.primaryColor,
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'Overdue'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: tasksProvider.tasks
                .where((task) =>
                    task.completed == false &&
                    task.dateTime!.kIsAfter(DateTime.now()))
                .length,
            itemBuilder: (context, index) {
              TaskModel taskModel = tasksProvider.tasks
                  .where((task) =>
                      task.completed == false &&
                      task.dateTime!.kIsAfter(DateTime.now()))
                  .toList()[index];
              return TaskTile(
                taskModel: taskModel,
                isHomeScreen: false,
              );
            },
          ),
          ListView.builder(
            itemCount: tasksProvider.tasks
                .where((task) => DateTime.now().kIsAfter(task.dateTime!))
                .length,
            itemBuilder: (context, index) {
              TaskModel taskModel = tasksProvider.tasks
                  .where((task) => DateTime.now().kIsAfter(task.dateTime!))
                  .toList()[index];
              return TaskTile(
                taskModel: taskModel,
                isHomeScreen: false,
              );
            },
          )
        ],
      ).padX(10),
    );
  }
}
