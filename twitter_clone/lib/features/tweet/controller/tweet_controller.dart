// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/core.dart';

class TweetController extends StateNotifier<bool> {
  TweetController() : super(false);

  void shareTweet({
    required List<File> images,
    required String tweet_text,
    required BuildContext context,
  }) {
    if (tweet_text.isEmpty) {
      showSnackBar(context, "Please Enter the text");
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
  }) {}

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
