import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:revised_clock/shared/services/alarm/alarm.service.dart';

import 'locator.dart';
import 'shared/routes/routes.dart';
import 'shared/services/hive/hive.service.dart';
import 'shared/services/navigation.service.dart';

const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT SERVICE LOCATOR
  setupLocator();

  locator<AlarmService>().init(wakeup: true);
  locator<HiveService>().init();

  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final navigatorService = locator<NavigationService>();
  final hiveSVC = locator<HiveService>();

  @override
  void initState() {
    super.initState();
    port.listen((val) => _fromIsolate(val));
  }

  void _fromIsolate(dynamic val) {
    final box = hiveSVC.getAlarms();
    box.delete(val);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      navigatorKey: navigatorService.rootNavKey,
      title: 'Revised Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
