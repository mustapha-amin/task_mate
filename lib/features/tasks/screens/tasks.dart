import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/providers/tasks_provider.dart';

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
          style: kTextStyle(30, isBold: true),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Overdue'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
              child: ListView.builder(
            itemCount: tasksProvider.tasks.length,
            itemBuilder: (context, index) {
              TaskModel taskModel = tasksProvider.tasks[index];
              return Text(taskModel.toString());
            },
          )),
          Center(child: Text('Content for Tab 2')),
        ],
      ),
    );
  }
}
