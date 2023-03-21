import 'package:flutter/material.dart';

class ColorResources {
  static Color primaryColor = Colors.green.shade100;
  static Color successBtnColor = Colors.green;
  static Color headlineColor=Colors.black;
  static Color colorConvert(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF" + color));
    } else if (color.length == 8) {
      return Color(int.parse("0x" + color));
    }
    return primaryColor;
  }
}