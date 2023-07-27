import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          LikeButton(
            size: 25,
            likeBuilder: (bool isLiked) {
              return isLiked
                  ? SvgPicture.asset(AssetsConstants.likeFilledIcon,
                      color: Pallete.redColor)
                  : SvgPicture.asset(
                      AssetsConstants.likeOutlinedIcon,
                      color: Pallete.greyColor,
                    );
            },
            likeCount: tweet.likes.length,
            countBuilder: (likeCount, isLiked, text) => Text(
              text,
              style: const TextStyle(color: Pallete.greyColor),
            ),
          ),
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
