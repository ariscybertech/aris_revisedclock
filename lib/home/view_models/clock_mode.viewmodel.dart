import 'package:flutter/foundation.dart';

enum ClockMode { analog, digital }

class ClockModeViewModel extends ValueNotifier<ClockMode> {
  ClockModeViewModel() : super(ClockMode.digital);

  ClockMode update(ClockMode mode) => mode;
}
