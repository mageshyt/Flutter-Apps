import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';

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
      body: Column(children: [
        TweetCard(tweet: tweet),
        ref.watch(getTweetRepliesProvider(tweet)).when(
              data: (tweets) {
                return ref.watch(getLatestTweetProvider).when(
                      data: (data) {
                        final latestTweet = Tweet.fromMap(data.payload);
                        bool isTweetAlreadyPresent = false;
                        for (final tweetModel in tweets) {
                          if (tweetModel.id == latestTweet.id) {
                            isTweetAlreadyPresent = true;
                            break;
                          }
                        }

                        if (!isTweetAlreadyPresent &&
                            latestTweet.repliedTo == tweet.id) {
                          if (data.events.contains(
                            'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.create',
                          )) {
                            tweets.insert(0, Tweet.fromMap(data.payload));
                          } else if (data.events.contains(
                            'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.update',
                          )) {
                            // get id of original tweet
                            final startingPoint =
                                data.events[0].lastIndexOf('documents.');
                            final endPoint =
                                data.events[0].lastIndexOf('.update');
                            final tweetId = data.events[0]
                                .substring(startingPoint + 10, endPoint);

                            var tweet = tweets
                                .where((element) => element.id == tweetId)
                                .first;

                            final tweetIndex = tweets.indexOf(tweet);
                            tweets.removeWhere(
                                (element) => element.id == tweetId);

                            tweet = Tweet.fromMap(data.payload);
                            tweets.insert(tweetIndex, tweet);
                          }
                        }

                        return Expanded(
                          child: ListView.builder(
                            itemCount: tweets.length,
                            itemBuilder: (BuildContext context, int index) {
                              final tweet = tweets[index];
                              return TweetCard(tweet: tweet);
                            },
                          ),
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        errorMessege: error.toString(),
                      ),
                      loading: () {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: tweets.length,
                            itemBuilder: (BuildContext context, int index) {
                              final tweet = tweets[index];
                              return TweetCard(tweet: tweet);
                            },
                          ),
                        );
                      },
                    );
              },
              error: (error, stackTrack) =>
                  ErrorText(errorMessege: error.toString()),
              loading: () => const Loader(),
            )
      ]),
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
