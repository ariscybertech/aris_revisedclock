import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChannels;

import 'package:hive/hive.dart';

import 'package:revised_clock/alarm/components/text/text.component.dart';
import 'package:revised_clock/alarm/models/alarm_time.model.dart';
import 'package:revised_clock/alarm/utils/strings.dart';
import 'package:revised_clock/home/components/button/button.component.dart';

import 'package:revised_clock/home/view_models/time.viewmodel.dart';
import 'package:revised_clock/locator.dart';
import 'package:revised_clock/main.dart';
import 'package:revised_clock/shared/services/alarm/alarm.service.dart';
import 'package:revised_clock/shared/services/hive/hive.service.dart';

import 'package:hive_flutter/hive_flutter.dart';

class AlarmComponent extends StatefulWidget {
  const AlarmComponent({Key key}) : super(key: key);

  @override
  _AlarmComponentState createState() => _AlarmComponentState();
}

class _AlarmComponentState extends State<AlarmComponent> {
  final alarmSVC = locator<AlarmService>();
  final hiveSVC = locator<HiveService>();
  final timeViewModel = locator<TimeViewModel>().time;

  ValueNotifier<String> hourVal;
  ValueNotifier<String> minuteVal;

  @override
  void initState() {
    super.initState();
    hourVal = ValueNotifier(timeViewModel.hour.toString());
    minuteVal = ValueNotifier(timeViewModel.minute.toString());
  }

  static Future<void> callback(int id) async {
    final SendPort uiSendPort = IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AlarmStrings.hour),
              const SizedBox(width: 10),
              TextComponent(
                initialVal: hourVal.value,
                onChanged: (val) => hourVal.value = val,
              ),
              const SizedBox(width: 20),
              const Text(AlarmStrings.minute),
              const SizedBox(width: 10),
              TextComponent(
                initialVal: minuteVal.value,
                onChanged: (val) => minuteVal.value = val,
              ),
            ],
          ),
          ButtonComponent(
            text: AlarmStrings.save,
            onPressed: () async {
              SystemChannels.textInput.invokeMethod('TextInput.hide');

              final time = AlarmTime()
                ..hour = hourVal.value
                ..minute = minuteVal.value;

              final id = Random().nextInt(pow(2, 31).toInt());

              final alarms = hiveSVC.getAlarms();
              alarms.put(id, time);

              if (Platform.isAndroid) {
                final currDate = DateTime.now();
                await alarmSVC.oneShotAt(
                    DateTime(
                      currDate.year,
                      currDate.month,
                      currDate.day,
                      int.parse(time.hour),
                      int.parse(time.minute),
                    ),
                    id,
                    callback);
              }
            },
          ),
          ValueListenableBuilder<Box<AlarmTime>>(
            valueListenable: hiveSVC.getAlarms().listenable(),
            builder: (context, value, _) {
              final list = value.values.toList();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, int index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.alarm),
                      title: Row(
                        children: [
                          Text(list[index].hour),
                          const Text(":"),
                          Text(list[index].minute),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () async => list[index].delete(),
                        child: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
