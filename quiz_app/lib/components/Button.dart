import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String label;
  final void Function(String option)? handleClick;
  final Color color;

  const Button({
    required this.color,
    required this.label,
    this.handleClick,
    Key? key,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          padding: const EdgeInsets.all(12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        ),
        onPressed: () {
          if (widget.handleClick != null) {
            widget.handleClick!(widget.label);
          }
        },
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16,
              textBaseline: TextBaseline.alphabetic,
              color: Color.fromARGB(255, 39, 141, 243),
              fontWeight: FontWeight.bold,
              fontFamily: AutofillHints.addressState),
        ),
      ),
    );
  }
}
