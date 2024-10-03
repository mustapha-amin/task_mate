import 'package:hive/hive.dart';
import 'package:task_mate/models/task_model.dart';

class TasksDB {
  Box<TaskModel> tasksBox;

  TasksDB({required this.tasksBox});

  Future<void> addTask(TaskModel task) async {
    await tasksBox.add(task);
  }

  Future<void> editTask(int? key, TaskModel newTask) async {
    await tasksBox.putAt(key!, newTask);
  }

  Future<void> deleteTask(TaskModel task) async {
    await task.delete();
  }

  List<TaskModel> fetchTasks() {
    return tasksBox.values.toList()
      ..sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
  }
}
