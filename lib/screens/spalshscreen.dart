import 'dart:async';
import 'dart:io';

import 'package:custom_clock/config/color_palette.dart';
import 'package:custom_clock/provider/themeprovider.dart';
import 'package:custom_clock/screens/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mainhomepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.getthemePreference();
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/clock.png',
                scale: 3,
              ),
              const SizedBox(height: 15),
              Text(
                'Alarm Clock',
                style: TextStyle(
                    color: primarycolor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Timer _initTimer() {
    return Timer(const Duration(seconds: 4), () {
      if (Platform.isIOS) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => const MainHomePage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const MainHomePage()),
        );
      }
    });
  }
}
