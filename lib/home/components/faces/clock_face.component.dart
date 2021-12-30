import 'package:flutter/material.dart';

import 'package:revised_clock/home/components/clock/clock_container.component.dart';
import 'package:revised_clock/home/components/painter/clock_painter.component.dart';
import 'package:revised_clock/home/view_models/time.viewmodel.dart';
import 'package:revised_clock/locator.dart';

class ClockFaceComponent extends StatelessWidget {
  const ClockFaceComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeViewModel = locator<TimeViewModel>();

    return ClockContainerComponent(
      child: AnimatedBuilder(
        animation: timeViewModel,
        builder: (context, _) {
          final model = timeViewModel.time;

          return Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: GenericPainterComponent(
                  clockHand: ClockHand.second,
                  hours: model.hour,
                  minutes: model.minute,
                  seconds: model.second,
                ),
              ),
              CustomPaint(
                painter: GenericPainterComponent(
                  clockHand: ClockHand.minute,
                  hours: model.hour,
                  minutes: model.minute,
                  seconds: model.second,
                ),
              ),
              CustomPaint(
                painter: GenericPainterComponent(
                  hours: model.hour,
                  minutes: model.minute,
                  seconds: model.second,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
