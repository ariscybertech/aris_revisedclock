import 'package:flutter/material.dart';
import 'package:revised_clock/alarm/components/list/alarm.component.dart';

import 'package:revised_clock/alarm/utils/strings.dart';

class AlarmView extends StatelessWidget {
  const AlarmView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AlarmStrings.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [AlarmComponent()],
        ),
      ),
    );
  }
}
