import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/providers/tasks_provider.dart';
import 'package:task_mate/services/notifications_service.dart';
import 'package:task_mate/shared/spacing.dart';
import 'package:task_mate/utils/textstyle.dart';

class TaskTile extends StatefulWidget {
  TaskModel? taskModel;
  bool? isHomeScreen;
  TaskTile({this.taskModel, this.isHomeScreen, super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  TextEditingController taskCtrl = TextEditingController();
  TextEditingController dateTimeCtrl = TextEditingController();
  DateTime? date;
  TimeOfDay? timeOfDay;
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    taskCtrl.text = widget.taskModel!.task!;
    dateTimeCtrl.text =
        "${DateFormat('d/M/y').format(widget.taskModel!.dateTime!)} - ${DateFormat.Hm().format(widget.taskModel!.dateTime!)}";
  }

  @override
  void dispose() {
    super.dispose();
    taskCtrl.dispose();
    dateTimeCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.grey[100],
      child: ListTile(
        title: Text(
          widget.taskModel!.task!,
          style: kTextStyle(18,
                  isBold: true,
                  color:
                      widget.taskModel!.completed! ? Colors.grey : Colors.black)
              .copyWith(
            decoration: widget.taskModel!.completed == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          DateFormat.Hm().format(widget.taskModel!.dateTime!),
        ),
        trailing: widget.isHomeScreen!
            ? Checkbox(
                value: widget.taskModel!.completed,
                onChanged: (val) => tasksProvider.editTask(
                  widget.taskModel!.key,
                  widget.taskModel!.copyWith(completed: val),
                ),
              )
            : IconButton(
                onPressed: () async {
                  tasksProvider.deleteTask(widget.taskModel!);
                  await NotificationService.cancelScheduledNotification(
                    widget.taskModel!.dateTime.hashCode,
                  );
                },
                icon: const Icon(Icons.delete),
              ),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Edit task"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: taskCtrl,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                      spaceY(10),
                      TextField(
                        readOnly: true,
                        controller: dateTimeCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          date = await showDatePicker(
                            context: context,
                            initialDate: widget.taskModel!.dateTime!,
                            firstDate: widget.taskModel!.dateTime!,
                            lastDate: DateTime(2099),
                          );
                          if (date != null) {
                            timeOfDay = await showTimePicker(
                                // ignore: use_build_context_synchronously
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false),
                                      child: child!);
                                });
                            if (timeOfDay != null) {
                              dateTime = DateTime(
                                  date!.year,
                                  date!.month,
                                  date!.day,
                                  timeOfDay!.hour,
                                  timeOfDay!.minute);
                              setState(() {
                                dateTimeCtrl.text =
                                    "${DateFormat('d/M/y').format(dateTime!)} - ${DateFormat.Hm().format(dateTime!)}";
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        tasksProvider.editTask(
                          widget.taskModel!.key!,
                          widget.taskModel!.copyWith(
                            task: taskCtrl.text.trim(),
                            dateTime: dateTime,
                            completed: false,
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save"),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
