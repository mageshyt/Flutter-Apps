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
