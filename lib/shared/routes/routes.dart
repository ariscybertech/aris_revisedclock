import 'package:flutter/material.dart';

import 'package:revised_clock/alarm/view/alarm.view.dart';
import 'package:revised_clock/home/view/home.view.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NamedRoute.home:
        return MaterialPageRoute<void>(
          builder: (context) => const HomeView(),
          settings: settings,
        );

      case NamedRoute.alarm:
        return MaterialPageRoute<void>(
          builder: (context) => const AlarmView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute<void>(
          builder: (_) => _UndefinedView(name: settings.name),
          settings: settings,
        );
    }
  }
}

class _UndefinedView extends StatelessWidget {
  const _UndefinedView({Key key, this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Something went wrong for $name'),
      ),
    );
  }
}

class NamedRoute {
  NamedRoute._();

  static const String home = '/';
  static const String alarm = '/alarm';
}
