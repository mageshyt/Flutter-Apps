// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TweetController extends StateNotifier<bool> {
  final Ref _ref;
  TweetController({
    required Ref ref,
  })  : _ref = ref,
        super(false);

  void shareTweet({
    required List<File> images,
    required String tweet_text,
    required BuildContext context,
  }) {
    if (tweet_text.isEmpty) {
      showSnackBar(context, "Please Enter the text","tweet error", ContentType.failure);
      return;
    }
    // if tweet with images
    if (images.isNotEmpty) {
      _shareImageTweet(
          context: context, images: images, tweet_text: tweet_text);
    } else {
      _shareTweet(context: context, tweet_text: tweet_text);
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String tweet_text,
    required BuildContext context,
  }) {}

  void _shareTweet({
    required String tweet_text,
    required BuildContext context,
  }) {
    state = true;
    final hashtags = _getHashTagsFromText(tweet_text);
    String link = _getLinkFromText(tweet_text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    Tweet tweet = Tweet(
        text: tweet_text,
        hashtags: hashtags,
        link: link,
        imageLinks: [],
        uid: user.uid,
        tweetType: TweetType.text,
        tweetedAt: DateTime.now(),
        likes: [],
        commentIds: [],
        id: '',
        reshareCount: 0);
  }

  String _getLinkFromText(String text) {
    final words = text.split(" ");
    String link = "";
    for (final word in words) {
      if (word.startsWith("https://") || word.startsWith("WWW://")) {
        link = word;
      }
    }
    return link;
  }

  // get #
  List<String> _getHashTagsFromText(String text) {
    final words = text.split(" ");
    final hashTags = <String>[];
    for (final word in words) {
      if (word.startsWith("#")) {
        hashTags.add(word);
      }
    }
    return hashTags;
  }
}
