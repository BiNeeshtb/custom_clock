// ignore_for_file: prefer_const_constructors

import 'package:custom_clock/model/alarm.dart';

import 'package:custom_clock/provider/alarm_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

import '../main.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime? _alarmTime;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    initialise();
    super.initState();
  }

  initialise() {
    final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
    alarmProvider.initializeDB().then((value) async {
      print('database intialized');
      await alarmProvider.getAlarms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmProvider>(builder: (context, alarm, child) {
      return Scaffold(
        body: alarm.alarmList.isEmpty
            ? const Center(
                child: Text('No Alarms'),
              )
            : ListView.builder(
                itemCount: alarm.alarmList.length,
                itemBuilder: (ctx, i) {
                  var alarmTime = DateFormat('hh:mm aa')
                      .format(alarm.alarmList[i].alarmTime!);
                  return _customTile(alarm.alarmList[i], alarmTime, alarm);
                }),
        floatingActionButton: _floatingButton(alarm),
      );
    });
  }

  _customTile(Alarm alarm, String alarmTime, AlarmProvider alarmProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.label,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          alarm.title!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Text(
                  'Mon-Fri',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      alarmTime,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                        onPressed: () async {
                          alarmProvider.delete(alarm.id!);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _floatingButton(AlarmProvider alarm) {
    return FloatingActionButton(
      child: const Icon(Icons.add_alarm),
      onPressed: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setModalState) {
                return Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Expanded(
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            brightness: Theme.of(context).brightness,
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              final now = DateTime.now();
                              var selectedDateTime = DateTime(now.year,
                                  now.month, now.day, value.hour, value.minute);
                              setState(() {
                                _alarmTime = selectedDateTime;
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          onSaveAlarm(alarm);
                        },
                        icon: Icon(Icons.alarm),
                        label: Text('Save'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void onSaveAlarm(AlarmProvider alarm) {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime!;
    } else {
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));
    }

    var alarmInfo = Alarm(
      title: 'alarm',
      alarmTime: scheduleAlarmDateTime,
    );
    alarm.insertAlarm(alarmInfo);

    Navigator.pop(context);
  }
}
