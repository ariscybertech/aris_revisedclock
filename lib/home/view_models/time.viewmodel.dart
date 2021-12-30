import 'dart:async' show Timer;

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:intl/intl.dart' show DateFormat;
import 'package:revised_clock/home/models/time.model.dart';

abstract class TimeVM extends ChangeNotifier {
  String get currentTime;
  TimeModel get time;
}

class TimeViewModel extends TimeVM {
  TimeViewModel() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      _timestamp = DateTime.now();
      notifyListeners();
    });
  }

  @override
  TimeModel get time {
    final model = TimeModel(
      _currentHour(_timestamp),
      _currentMinute(_timestamp),
      _currentSecond(_timestamp),
    );

    return model;
  }

  @override
  String get currentTime => _formatDateTime(_timestamp);

  // INTERNALS
  DateTime _timestamp = DateTime.now();

  String _formatDateTime(DateTime timestamp) {
    final hour = DateFormat('HH').format(timestamp);
    final minute = DateFormat('mm').format(timestamp);
    final seconds = DateFormat('ss').format(timestamp);

    return '$hour:$minute:$seconds';
  }

  int _currentHour(DateTime timestamp) {
    final hour = DateFormat('HH').format(timestamp);
    return int.parse(hour);
  }

  int _currentMinute(DateTime timestamp) {
    final minute = DateFormat('mm').format(timestamp);
    return int.parse(minute);
  }

  int _currentSecond(DateTime timestamp) {
    final second = DateFormat('ss').format(timestamp);
    return int.parse(second);
  }
}
