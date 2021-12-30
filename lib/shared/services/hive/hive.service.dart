import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:revised_clock/alarm/models/alarm_time.model.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(AlarmTimeAdapter());
    await Hive.openBox<AlarmTime>(alarmBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  final String alarmBox = 'alarms';

  Box<AlarmTime> getAlarms() => Hive.box<AlarmTime>(alarmBox);
}
