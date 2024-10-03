import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/features/btm_nav_bar/btm_nav_bar.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/providers/tasks_provider.dart';
import 'package:task_mate/services/tasks_db.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('task_db');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TasksDB>(
          create: (_) => TasksDB(tasksBox: Hive.box<TaskModel>('task_db')),
        ),
        ChangeNotifierProvider<TasksProvider>(
          create: (context) => TasksProvider(
            tasksDB: Provider.of<TasksDB>(context, listen: false),
          ),
        )
      ],
      child: Sizer(
        builder: (_, __, ___) {
          return MaterialApp(
            theme: ThemeData.from(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: const Color(0xFF007AFF))),
            home: const AppBottomNavBar(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
