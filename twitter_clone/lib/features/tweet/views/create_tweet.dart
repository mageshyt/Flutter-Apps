import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/theme/pallet.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CreateTweet extends ConsumerStatefulWidget {
  const CreateTweet({Key? key}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const CreateTweet());
  }

  @override
  ConsumerState<CreateTweet> createState() => _CreateTweetState();
}

class _CreateTweetState extends ConsumerState<CreateTweet> {
  List<File> images = [];
  // onClose go home screen

  onClose() {
    Navigator.pop(context);
  }

  void onPickImages() async {
    images = await pickImage();
    setState(() {});
  }

  void shareTweet() {
    // tweet text
    ref.read(TweetControllerProvider.notifier).shareTweet(
        images: images, tweet_text: tweetController.text, context: context);

    // close the screen
    onClose();
  }

  final tweetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // print(images);
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(TweetControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onClose,
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          RoundedButton(
              onTap: shareTweet,
              label: "Tweet",
              bgColor: Pallete.blueColor,
              textColor: Pallete.whiteColor)
        ],
      ),
      body: isLoading || currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(currentUser.avatar),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: tweetController,
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                            decoration: const InputDecoration(
                              hintText: "what's happening ?",
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        )
                      ],
                    ),
                    if (images.isNotEmpty)
                      CarouselSlider(
                          items: images
                              .map(
                                (file) => Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Image.file(file),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 400,
                            enableInfiniteScroll: false,
                          ))
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Pallete.greyColor, width: 0.3))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
              child: GestureDetector(
                  onTap: onPickImages,
                  child: SvgPicture.asset(AssetsConstants.galleryIcon)),
            ),
            Padding(
              padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
              child: SvgPicture.asset(AssetsConstants.emojiIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
              child: SvgPicture.asset(AssetsConstants.gifIcon),
            )
          ],
        ),
      ),
    );
  }
}
