import 'package:hive/hive.dart';

part 'alarm_time.model.g.dart';

@HiveType(typeId: 0)
class AlarmTime extends HiveObject {
  @HiveField(0)
  String hour;

  @HiveField(1)
  String minute;
}
