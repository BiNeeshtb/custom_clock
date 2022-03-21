import 'package:custom_clock/config/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = apptheme == 'light' ? ThemeMode.light : ThemeMode.dark;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    setthemePreference(themeMode.name);
    getthemePreference();
    print(apptheme);
    notifyListeners();
  }

  setthemePreference(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
    apptheme = theme;
  }

  getthemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apptheme = prefs.getString('theme') ?? 'light';
  }
}
