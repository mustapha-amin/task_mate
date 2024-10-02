import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_mate/utils/colors.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppConstants.primaryColor,
        gradient: LinearGradient(colors: [
          Colors.blue[300]!,
          Colors.blue[900]!,
        ]),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
