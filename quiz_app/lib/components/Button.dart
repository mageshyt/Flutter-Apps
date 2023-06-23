import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String label;
  final void Function()? handleClick;
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
      margin: const EdgeInsets.only(top: 20.0),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            backgroundColor: widget.color,
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
        onPressed: widget.handleClick,
        label: Text(
          widget.label,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        icon: const Icon(
          Icons.arrow_right_alt_sharp,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
