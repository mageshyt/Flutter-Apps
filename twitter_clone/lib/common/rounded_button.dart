import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? size;
  final String label;
  final Color? bgColor;
  final Color? textColor;

  const RoundedButton(
      {Key? key,
      required this.onTap,
      this.size,
      required this.label,
      this.bgColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        backgroundColor: bgColor,
        labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      ),
    );
  }
}
