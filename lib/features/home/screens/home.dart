import 'package:flutter/material.dart';
import 'package:task_mate/features/home/widgets/progress_widget.dart';
import 'package:task_mate/utils/extensions.dart';

import '../../../utils/textstyle.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TaskMate",
          style: kTextStyle(30, isBold: true),
        ).padX(15),
      ),
      body: Column(
        children: [
          ProgressWidget(),
        ],
      ).padX(25),
    );
  }
}
