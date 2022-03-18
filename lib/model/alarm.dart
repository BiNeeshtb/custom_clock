class Alarm {
  int? id;
  String? title;
  DateTime? alarmTime;

  Alarm({this.id, this.title, this.alarmTime});

  factory Alarm.fromMap(Map<String, dynamic> json) => Alarm(
        id: json["id"],
        title: json["title"],
        alarmTime: DateTime.parse(json["alarmTime"]),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmTime": alarmTime!.toIso8601String(),
      };
}
