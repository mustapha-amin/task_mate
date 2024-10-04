import 'package:flutter/material.dart';

extension WidgetExts on Widget {
  Widget padX(double size) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size),
        child: this,
      );

  Widget padY(double size) => Padding(
        padding: EdgeInsets.symmetric(vertical: size),
        child: this,
      );
}

extension DateTimeExts on DateTime {
  bool isSameDayAs(DateTime? other) {
    return day == other!.day && month == other.month && year == other.year;
  }

  bool kIsAfter(DateTime? other) {
    bool sameYear = year == other!.year;
    bool sameMonth = month == other.month;
    if (sameYear) {
      if (sameMonth) {
        return DateTime.now().day > other.day;
      } else {
        return DateTime.now().month > other.month;
      }
    }
    return false;
  }
}
