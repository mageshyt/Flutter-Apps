import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_button.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/theme/pallet.dart';

class TweetAction extends StatelessWidget {
  final Tweet tweet;
  TweetAction({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: tweet.tweetType == TweetType.image
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          TweetButton(
              pathname: AssetsConstants.viewsIcon,
              text: (tweet.likes.length +
                      tweet.reshareCount +
                      tweet.commentIds.length)
                  .toString(),
              onTap: () {}),
          TweetButton(
              pathname: AssetsConstants.commentIcon,
              text: tweet.commentIds.length.toString(),
              onTap: () {}),
          TweetButton(
              pathname: AssetsConstants.retweetIcon,
              text: tweet.reshareCount.toString(),
              onTap: () {}),
          TweetButton(
              pathname: AssetsConstants.likeOutlinedIcon,
              text: tweet.likes.length.toString(),
              onTap: () {}),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                size: 20,
                color: Pallete.greyColor,
              ))
        ],
      ),
    );
  }
}
