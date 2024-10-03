import 'package:flutter/material.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/services/tasks_db.dart';

class TasksProvider extends ChangeNotifier {
  final TasksDB tasksDB;
  List<TaskModel> tasks = [];

  TasksProvider({required this.tasksDB}) {
    fetchTasks();
  }

  void fetchTasks() {
    tasks = tasksDB.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    await tasksDB.addTask(task);
    fetchTasks();
  }

  Future<void> editTask(int? key, TaskModel newTask) async {
    await tasksDB.editTask(key, newTask);
    fetchTasks();
  }

  Future<void> deleteTask(TaskModel task) async {
    await tasksDB.deleteTask(task);
    fetchTasks();
  }
}
