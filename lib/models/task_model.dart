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
  int? categoryIndex;

  TaskModel({
    this.task,
    this.dateTime,
    this.completed,
    this.categoryIndex,
  });

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is TaskModel &&
            dateTime == other.dateTime &&
            task == other.task &&
            completed == other.completed &&
            categoryIndex == other.categoryIndex;
  }

  @override
  int get hashCode => task.hashCode ^ dateTime.hashCode ^ completed.hashCode;

  @override
  String toString() {
    return "$task ${dateTime.toString()} $completed $categoryIndex";
  }

  TaskModel copyWith({
    String? task,
    DateTime? dateTime,
    bool? completed,
    int? categoryIndex,
  }) {
    return TaskModel(
      task: task ?? this.task,
      dateTime: dateTime ?? this.dateTime,
      completed: completed ?? this.completed,
      categoryIndex: categoryIndex ?? this.categoryIndex,
    );
  }
}
