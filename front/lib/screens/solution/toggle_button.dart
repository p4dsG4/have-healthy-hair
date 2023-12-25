import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onPressed;
  final bool disabled;

  const ToggleButton({
    Key? key,
    required this.text,
    required this.selected,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(280, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(
          selected ? Colors.green : (disabled ? Colors.grey : Colors.white),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: selected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}