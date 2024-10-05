import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:task_mate/services/notifications_service.dart';
import 'package:task_mate/services/tasks_db.dart';

import '../../utils/colors.dart';
import '../add_task/screens/add_task.dart';
import '../home/screens/home.dart';
import '../tasks/screens/tasks.dart';
import 'package:permission_handler/permission_handler.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({super.key});

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int _currentIndex = 0;

  void requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (!status.isGranted) {
      Permission.notification.request();
    }
  }

  @override
  void initState() {
    requestNotificationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? const Home() : const Tasks(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_sharp),
            label: "Tasks",
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTask(),
                  ),
                );
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 3,
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
