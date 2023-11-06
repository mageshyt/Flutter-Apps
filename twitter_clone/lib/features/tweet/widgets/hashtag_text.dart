import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallet.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        spans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('Hashtag $element');
              }));
      } else if (element.startsWith('wwww.') ||
          element.startsWith('https://')) {
        spans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(color: Pallete.blueColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('Hashtag $element');
              }));
      } else {
        spans.add(TextSpan(
          text: '$element ',
        ));
      }
    });

    return RichText(
      text: TextSpan(
        children: spans,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
