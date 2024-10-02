import 'package:flutter/material.dart';
import 'package:task_mate/features/add_task/screens/add_task.dart';
import 'package:task_mate/features/btm_nav_bar/btm_nav_bar.dart';
import 'package:task_mate/features/tasks/screens/tasks.dart';
import 'package:task_mate/utils/colors.dart';
import 'package:sizer/sizer.dart';
import 'features/home/screens/home.dart';

void main() {
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
    return Sizer(builder: (context, __, ___) {
      return MaterialApp(
        theme: ThemeData.from(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF007AFF))),
        home: AppBottomNavBar(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
