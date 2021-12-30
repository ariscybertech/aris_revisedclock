import 'package:flutter/material.dart';

typedef ButtonPressed = void Function();

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    Key key,
    @required this.onPressed,
    this.text = 'Change Mode',
  })  : assert(onPressed != null),
        super(key: key);

  final ButtonPressed onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.button),
    );
  }
}
