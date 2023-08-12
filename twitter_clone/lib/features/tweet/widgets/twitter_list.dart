import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TwitterList extends ConsumerWidget {
  const TwitterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
        data: (tweets) {
          
          return ref.watch(getLatestTweetProvider).when(
                data: (data) {
                  if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.create')) {
                    print('new tweet');
                    tweets.insert(0, Tweet.fromMap(data.payload));
                  } else if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.update')) {
                    print('updating tweet');
                    // get id of tweet
                    var tweet = Tweet.fromMap(data.payload);
                    final tweetId = tweet.id;
                    // get index of tweet
                    final index =
                        tweets.indexWhere((element) => element.id == tweetId);
                    // update tweet
                    tweets[index] = tweet;
                  }
                  return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: (context, index) {
                        final tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      });
                },
                error: (error, stackTrack) =>
                    ErrorText(errorMessege: error.toString()),
                loading: () {
                  return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: (context, index) {
                        final tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      });
                },
              );
        },
        error: (error, stackTrack) => ErrorText(errorMessege: error.toString()),
        loading: () => const Loader());
  }
}
