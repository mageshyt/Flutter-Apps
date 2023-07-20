import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TweetCard extends StatelessWidget {
  final Tweet tweet;
  const TweetCard({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 40, 40, 40),
      ),
      margin: EdgeInsets.all(10),
      child: Text(tweet.text),
    );
  }
}
