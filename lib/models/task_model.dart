import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String? task;
  @HiveField(1)
  DateTime? dateTime;
  @HiveField(2)
  bool? completed;
  @HiveField(3)
  String? category;

  TaskModel({
    this.task,
    this.dateTime,
    this.completed,
    this.category,
  });

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is TaskModel &&
            dateTime == other.dateTime &&
            task == other.task &&
            completed == other.completed &&
            category == other.category;
  }

  @override
  int get hashCode => task.hashCode ^ dateTime.hashCode ^ completed.hashCode;

  @override
  String toString() {
    return "$task ${dateTime.toString()} $completed $category";
  }

  TaskModel copyWith({
    String? task,
    DateTime? dateTime,
    bool? completed,
    String? category,
  }) {
    return TaskModel(
      task: task ?? this.task,
      dateTime: dateTime ?? this.dateTime,
      completed: completed ?? this.completed,
      category: category ?? this.category,
    );
  }
}
