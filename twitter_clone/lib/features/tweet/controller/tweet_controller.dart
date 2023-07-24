// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/storage_api.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final TweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(
    ref: ref,
    tweetApi: ref.watch(tweetApiProvider),
    storageApi: ref.watch(storageProvider),
  );
});

final getTweetsProvider = FutureProvider((ref) async {
  final tweetController = ref.watch(TweetControllerProvider.notifier);
  return await tweetController.getTweets();
});

class TweetController extends StateNotifier<bool> {
  final TweetAPI _tweetApi;
  final Ref _ref;
  final StorageAPI _storageApi;
  TweetController({
    required Ref ref,
    required TweetAPI tweetApi,
    required StorageAPI storageApi,
  })  : _ref = ref,
        _tweetApi = tweetApi,
        _storageApi = storageApi,
        super(false);

  Future<List<Tweet>> getTweets() async {
    final tweetList = await _tweetApi.getTweets();

    return tweetList.map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  void shareTweet({
    required List<File> images,
    required String tweet_text,
    required BuildContext context,
  }) {
    state = true;
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
    state = false;
  }

  void _shareImageTweet({
    required List<File> images,
    required String tweet_text,
    required BuildContext context,
  }) async {
    final hashtags = _getHashTagsFromText(tweet_text);
    String link = _getLinkFromText(tweet_text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    // upload images
    final imageUrls = await _storageApi.uploadImages(images);
    // create tweet object
    Tweet tweet = Tweet(
      text: tweet_text,
      hashtags: hashtags,
      link: link,
      imageLinks: imageUrls,
      uid: user.uid,
      tweetType: TweetType.image,
      tweetedAt: DateTime.now(),
      likes: [],
      commentIds: [],
      id: '',
      reshareCount: 0,
    );

    final res = await _tweetApi.shareTweet(tweet);

    res.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, "Tweet Shared Successfully");
    });
  }

  void _shareTweet({
    required String tweet_text,
    required BuildContext context,
  }) async {
    final hashtags = _getHashTagsFromText(tweet_text);
    String link = _getLinkFromText(tweet_text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    // create tweet object
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
      reshareCount: 0,
    );

    final res = await _tweetApi.shareTweet(tweet);

    res.fold((l) {
      showSnackBar(context, l.message);
    }, (r) => showSnackBar(context, "Tweet Shared Successfully"));
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
