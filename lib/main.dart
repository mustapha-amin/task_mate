import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/features/btm_nav_bar/btm_nav_bar.dart';
import 'package:task_mate/features/onboarding/onboarding.dart';
import 'package:task_mate/models/category_model.dart';
import 'package:task_mate/models/task_model.dart';
import 'package:task_mate/providers/categories_provider.dart';
import 'package:task_mate/providers/tasks_provider.dart';
import 'package:task_mate/services/categories_db.dart';
import 'package:task_mate/services/tasks_db.dart';
import 'package:sizer/sizer.dart';

import 'services/notifications_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<TaskModel>('tasks_db0');
  await Hive.openBox<CategoryModel>('categories_db');
  await NotificationService.init();
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
          create: (_) => TasksDB(tasksBox: Hive.box<TaskModel>('tasks_db0')),
        ),
        Provider<CategoriesDB>(
          create: (_) =>
              CategoriesDB(tasksBox: Hive.box<CategoryModel>('categories_db')),
        ),
        ChangeNotifierProvider<TasksProvider>(
          create: (context) => TasksProvider(
            tasksDB: Provider.of<TasksDB>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (context) => CategoriesProvider(
            categoriesDB: Provider.of<CategoriesDB>(context, listen: false),
          ),
        ),
      ],
      child: Sizer(
        builder: (_, __, ___) {
          return MaterialApp(
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF007AFF),
              ),
            ),
            home: FutureBuilder(
              future: Permission.notification.isGranted,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return switch (snapshot.data) {
                    true => const AppBottomNavBar(),
                    _ => const OnboardingScreen(),
                  };
                }
              },
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
