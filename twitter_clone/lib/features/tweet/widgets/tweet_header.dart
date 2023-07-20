import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallet.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetHeader extends StatelessWidget {
  final String name;
  final DateTime tweetedAt;
  const TweetHeader({Key? key, required this.name, required this.tweetedAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        //! Tweet Time and @
        Text(
          '@ ${name} • ${timeago.format(tweetedAt, locale: 'en_short')} ',
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Pallete.greyColor),
        ),
      ],
    );
  }
}
