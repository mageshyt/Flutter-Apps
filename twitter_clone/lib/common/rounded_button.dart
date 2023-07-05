import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallet.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String size;
  final String label;
  final Color bgColor;
  final Color textColor;

  const RoundedButton(
      {Key? key,
      required this.onTap,
      required this.size,
      required this.label,
      required this.bgColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      backgroundColor: this.bgColor,
      labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    );
  }
}
