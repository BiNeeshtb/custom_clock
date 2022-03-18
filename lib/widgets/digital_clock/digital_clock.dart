import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({Key? key}) : super(key: key);

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  double? percentValue;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    percentValue = DateTime.now().second / 60;
    updateSeconds();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularPercentIndicator(
        radius: 300.0,
        lineWidth: 8.0,
        percent: percentValue!,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        center: Text(
          time(),
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }

  String time() {
    return "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : ${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second} ";
  }

  updateSeconds() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (!mounted) return;
        setState(() {
          percentValue = DateTime.now().second / 60;
        });
      },
    );
  }
}
