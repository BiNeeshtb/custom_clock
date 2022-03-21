import 'package:custom_clock/config/color_palette.dart';
import 'package:custom_clock/provider/themeprovider.dart';
import 'package:custom_clock/widgets/analog_clock/analog_clock.dart';
import 'package:custom_clock/widgets/change_theme_button_widget.dart';
import 'package:custom_clock/widgets/digital_clock/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeDependencies.scaffoldColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              _customswitch(),
              const SizedBox(height: 20),
              !_switchValue ? const AnalogClock() : const DigitalClock(),
            ],
          ),
        ),
      ),
    );
  }

  _customswitch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Theme.of(context).primaryColorLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Analog',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              activeColor: Theme.of(context).primaryColorDark,
              inactiveThumbColor:
                  Theme.of(context).primaryColor.withOpacity(0.8),
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white,
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            const Text(
              'Digital',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
