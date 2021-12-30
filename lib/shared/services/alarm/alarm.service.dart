import 'dart:async' show Future;
import 'dart:io';

import 'package:flutter/material.dart' show debugPrint;

import 'package:android_alarm_manager/android_alarm_manager.dart';

class AlarmService {
  AlarmService();

  Future<bool> init({
    bool wakeup = false,
    DateTime startAt,
  }) async {
    if (!Platform.isAndroid) return false;

    if (_init) return _init;
    _init = true;

    bool init;
    try {
      init = await AndroidAlarmManager.initialize();
    } catch (ex) {
      debugPrint('Error in init ${ex.toString()}');
      return false;
    }
    if (!init) {
      debugPrint('Error in init:AndroidAlarmManager not initialize');
    }

    return true;
  }

  static bool _init = false;

  Future<bool> cancel(int id) async {
    bool cancel;
    try {
      cancel = await AndroidAlarmManager.cancel(id);
    } catch (ex) {
      cancel = false;
      debugPrint('Error in cancel ${ex.toString()}');
    }
    return cancel;
  }

  Future<void> oneShotAt(DateTime dateTime, int id, Function callback) async {
    try {
      await AndroidAlarmManager.oneShotAt(dateTime, id, callback);
    } catch (ex) {
      debugPrint('Error in oneShotAt ${ex.toString()}');
    }
  }
}
