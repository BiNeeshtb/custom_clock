import 'package:custom_clock/model/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AlarmProvider with ChangeNotifier {
  List<Alarm> _alarmList = [];
  List<Alarm> get alarmList => [..._alarmList];

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'alarms.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE alarmtable(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, alarmTime TEXT)',
        );
      },
      version: 1,
    );
  }

  void insertAlarm(Alarm alarmInfo) async {
    final db = await initializeDB();
    var result = await db
        .insert(
      'alarmtable',
      alarmInfo.toMap(),
    )
        .then((val) async {
      Alarm alarm = Alarm(
          id: val, title: alarmInfo.title, alarmTime: alarmInfo.alarmTime);
      _alarmList.add(alarm);
      notifyListeners();
      await scheduleAlarm(alarm.alarmTime!, alarm);
    });
  }

  Future<List<Alarm>> getAlarms() async {
    List<Alarm> _alarms = [];

    final db = await initializeDB();
    var result = await db.query('alarmtable');
    for (var element in result) {
      var alarmInfo = Alarm.fromMap(element);
      _alarms.add(alarmInfo);
    }
    _alarmList = _alarms.toSet().toList();
    notifyListeners();

    return _alarmList;
  }

  void delete(int id) async {
    final db = await initializeDB();
    await db.delete('alarmtable', where: 'id = ?', whereArgs: [id]).then(
        (value) async {
      _alarmList.removeWhere((e) => e.id == id);
      notifyListeners();
      await _removeScheduledAlarm(id);
    });
  }

  Future<void> scheduleAlarm(
      DateTime scheduledNotificationDateTime, Alarm alarm) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notification',
      'alarm_notification',
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        alarm.id ?? 0,
        'Alarm at ${DateFormat('hh:mm aa').format(alarm.alarmTime!)}',
        'Time is Up It is ${DateFormat('hh:mm aa').format(alarm.alarmTime!)}',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> _removeScheduledAlarm(int id) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
