import 'package:flutter/material.dart';

class ClockContainerComponent extends StatelessWidget {
  final Widget child;

  const ClockContainerComponent({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue),
      ),
      child: child,
    );
  }
}
