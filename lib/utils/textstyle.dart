import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

TextStyle kTextStyle(double size, {Color color = Colors.black, bool isBold = false}) {
  return TextStyle(
    fontSize: size.sp,
    color: color,
    fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
    fontFamily: "JosefinSans"
  );
}
