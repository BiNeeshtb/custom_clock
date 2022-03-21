import 'package:flutter/material.dart';

const primarycolor = Colors.blue;
const whiteColor = Colors.white;
const blackcolor = Colors.black87;
const activecolor = Color(0XFF87d8f7);
const inactivecolor = Colors.teal;
const navbardarkcolor = Color(0XFF405b6c);

String apptheme = '';

class ThemeDependencies {
  static Color get dummytextcolor =>
      apptheme == "light" ? primarycolor : Colors.red;

  static Color get scaffoldColor =>
      apptheme == "light" ? whiteColor : blackcolor;

  static Color get navbarColor =>
      apptheme == "light" ? whiteColor : navbardarkcolor;

  static Color get navbaractiveColor =>
      apptheme == "light" ? activecolor : blackcolor;
}
