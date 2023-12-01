import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  ToggleButton(this.text, {super.key, this.disabled = false, required this.onPressed});
  final String text;
  final bool disabled;
  final void Function(bool) onPressed;

  @override
  State<StatefulWidget> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool selected = false;

  onPressed() {
    setState(() {
      selected = !selected;
      widget.onPressed(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _disabled = !selected && widget.disabled;
    return ElevatedButton(
      onPressed: _disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: selected
            ? Colors.lightGreen
            : _disabled
            ? const Color(0x6623262F)
            : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.transparent), // Optional border
        ),
        elevation: 5, // Adjust the elevation to control the shadow intensity
      ),
      child: Container(
        height: 70,
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : _disabled
                  ? const Color(0xFF23262F)
                  : Colors.black,
              fontSize: selected ? 18 : 18,
            ),
          ),
        ),
      ),
    )
    ;
  }
}
