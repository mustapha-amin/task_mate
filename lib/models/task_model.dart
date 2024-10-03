import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String? task;
  @HiveField(1)
  DateTime? dateTime;
  @HiveField(2)
  bool? completed;
  @HiveField(3)
  int? categoryIndex;

  TaskModel({
    required String task,
    required DateTime dateTime,
    required bool completed,
    required int categoryIndex,
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

}
