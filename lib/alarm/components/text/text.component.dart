import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextComponent extends StatefulWidget {
  const TextComponent({
    Key key,
    @required this.onChanged,
    this.initialVal = '',
  }) : super(key: key);

  final String initialVal;
  final ValueChanged<String> onChanged;

  @override
  _TextComponentState createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.initialVal;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        inputFormatters: [LengthLimitingTextInputFormatter(2)],
        controller: textController,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }
}
