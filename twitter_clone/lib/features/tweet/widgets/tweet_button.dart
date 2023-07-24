import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/theme/pallet.dart';

class TweetButton extends StatelessWidget {
  final String pathname;
  final String text;
  final VoidCallback onTap;
  const TweetButton(
      {Key? key,
      required this.pathname,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Row(children: [
          SvgPicture.asset(
            pathname,
            color: Pallete.greyColor,
          ),
          Container(margin: const EdgeInsets.all(10), child: Text(text)),
        ]));
  }
}
