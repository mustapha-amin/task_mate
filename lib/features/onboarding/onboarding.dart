import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:task_mate/features/add_task/screens/add_task.dart';
import 'package:task_mate/features/btm_nav_bar/btm_nav_bar.dart';
import 'package:task_mate/shared/spacing.dart';
import 'package:task_mate/utils/colors.dart';
import 'package:task_mate/utils/extensions.dart';
import 'package:task_mate/utils/textstyle.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/task_gif.gif",
                height: 45.h,
              ),
              Text(
                "Welcome to TaskMate",
                style: kTextStyle(25, isBold: true),
              ),
              spaceY(20),
              Text(
                "Your personal task management app. Keep track of your daily tasks and get reminders. Stay organized and productive. One task at a time",
                style: kTextStyle(
                  16,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: 95.w,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  // minimumSize: Size(100.w, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (!await Permission.notification.status.isGranted) {
                    Permission.notification.request().then((status) {
                      if (status == PermissionStatus.granted) {
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppBottomNavBar(),
                          ),
                        );
                      }
                    });
                  }
                },
                child: Text(
                  "Get started",
                  style: kTextStyle(17, isBold: true, color: Colors.white),
                ),
              ).padY(12),
            ).padX(0),
          ),
        ],
      ).padX(10),
    );
  }
}
