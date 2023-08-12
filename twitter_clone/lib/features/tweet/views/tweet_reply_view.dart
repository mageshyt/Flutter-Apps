import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TweetReplyView extends ConsumerWidget {
  static Route<dynamic> route(tweet) {
    return MaterialPageRoute(
        builder: (context) => TweetReplyView(
              tweet: tweet,
            ));
  }

  final Tweet tweet;
  const TweetReplyView({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tweet"),
      ),
      body: Column(children: [TweetCard(tweet: tweet)]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: TextField(
          onSubmitted: (value) {
            ref.read(TweetControllerProvider.notifier).shareTweet(
                images: [],
                tweet_text: value,
                context: context,
                repliedTo: tweet.id);
          },
          decoration: const InputDecoration(hintText: "tweet your reply"),
        ),
      ),
    );
  }
}
