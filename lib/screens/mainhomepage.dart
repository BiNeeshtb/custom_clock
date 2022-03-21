import 'dart:io';

import 'package:custom_clock/config/color_palette.dart';
import 'package:custom_clock/provider/themeprovider.dart';
import 'package:custom_clock/widgets/change_theme_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homePage.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: ThemeDependencies.scaffoldColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sun(),
              _moon(),
              const SizedBox(height: 20),
              _navigate(),
              const SizedBox(height: 20),
              _theme(theme),
            ],
          ),
        ),
      ),
    );
  }

  _navigate() {
    return InkWell(
      onTap: () {
        if (Platform.isIOS) {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (ctx) => const HomePage()),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const HomePage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: activecolor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'View Clock',
            style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  _moon() {
    return Visibility(
      visible: apptheme != "light",
      child: Container(
        height: 200,
        width: 200,
        child: Image.asset(
          'assets/moon.png',
        ),
      ),
    );
  }

  _sun() {
    return Visibility(
      visible: apptheme == "light",
      child: Container(
        height: 200,
        width: 200,
        child: Image.asset(
          'assets/sun.png',
        ),
      ),
    );
  }

  _theme(ThemeProvider theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Light',
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
        ChangeThemeButtonWidget(theme: theme),
        Text(
          'Dark',
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
