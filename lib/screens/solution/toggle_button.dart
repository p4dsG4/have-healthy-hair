import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  ToggleButton(this.text, {super.key,
    this.disabled = false,
    required this.onPressed
  });
  final String text;
  final bool disabled;
  final void Function(bool) onPressed;

  @override
  State<StatefulWidget> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool selected = false;

  onPressed(){
    setState(() {
      selected = !selected;
      widget.onPressed(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _disabled = !selected && widget.disabled;
    return TextButton(
      onPressed: _disabled? null : onPressed,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        color: selected ? Colors.lightGreen
            : _disabled ? const Color(0x6623262F) : Colors.grey[300],
        child: Center(child:Text(widget.text,
          style: TextStyle(
            color: selected ? Colors.white
                : _disabled ? const Color(0xFF23262F) : Colors.black,
            fontSize: selected ? 15 : 14,
          ),
        )),
      ),
    );
  }
}