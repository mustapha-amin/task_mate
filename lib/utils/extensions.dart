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

  bool kIsAfter(DateTime other) {
    if (year > other.year) return true;
    if (year < other.year) return false;

    if (month > other.month) return true;
    if (month < other.month) return false;

    return day > other.day;
  }
}
