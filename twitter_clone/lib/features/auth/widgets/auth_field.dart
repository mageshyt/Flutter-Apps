import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallet.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  // ignore: non_constant_identifier_names
  final String hint_text;
  const AuthField({Key? key, required this.controller, required this.hint_text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Pallete.blueColor, width: 2)),
        contentPadding: const EdgeInsets.all(22),
        hintText: hint_text,
        hintStyle: const TextStyle(fontSize: 18),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Pallete.greyColor, width: 2),
        ),
      ),
    );
  }
}
