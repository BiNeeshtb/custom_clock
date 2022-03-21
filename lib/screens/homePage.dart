import 'package:custom_clock/config/color_palette.dart';
import 'package:custom_clock/provider/themeprovider.dart';
import 'package:custom_clock/screens/alarm_page.dart';
import 'package:custom_clock/screens/clock_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/analog_clock/analog_clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Consumer<ThemeProvider>(builder: (context, theme, _) {
        return Scaffold(
          backgroundColor: ThemeDependencies.scaffoldColor,
          body: _children[_selectedIndex],
          bottomNavigationBar: _customBottomnavBar(),
        );
      });
    });
  }

  _customBottomnavBar() {
    return BottomNavigationBar(
      backgroundColor: ThemeDependencies.navbarColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time_outlined),
          label: 'Clockview',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm),
          label: 'Set Alarm',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  final List<Widget> _children = [
    const ClockPage(),
    const AlarmPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
