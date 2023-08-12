import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/views/tweet_reply_view.dart';
import 'package:twitter_clone/features/tweet/widgets/carousel_image.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtag_text.dart';
import 'package:twitter_clone/features/tweet/widgets/retwitted_header.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_action.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_header.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/theme/pallet.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(tweet.uid)).when(
        data: (user) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, TweetReplyView.route(tweet));
            },
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //* Profile Image
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                  ),

                  //* Tweet Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  * ReTwitted
                        if (tweet.retweetedBy.isNotEmpty)
                          ReTwittedHeader(retweetedBy: tweet.retweetedBy),
                        // * Tweet Header
                        TweetHeader(
                            name: user.name, tweetedAt: tweet.tweetedAt),
                        HashtagText(text: tweet.text),
                        // * Tweet Images
                      ],
                    ),
                  ),
                ],
              ),
              if (tweet.tweetType == TweetType.image)
                CarouselImage(images: tweet.imageLinks),

              // * Tweet links
              // if (tweet.link.isNotEmpty) ...[
              //   const SizedBox(
              //     height: 4,
              //   ),
              //   AnyLinkPreview(link: 'https://${tweet.link}')
              // ],

              // * Tweet Action
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TweetAction(tweet: tweet)),
              const Divider(
                color: Pallete.greyColor,
              )
            ]),
          );
        },
        error: (error, stackTrack) => ErrorText(errorMessege: error.toString()),
        loading: () => const Loader());
  }
}
