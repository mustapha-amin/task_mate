import 'package:flutter/material.dart';

TextStyle kTextStyle(double size, {Color color = Colors.black, bool isBold = false}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}
