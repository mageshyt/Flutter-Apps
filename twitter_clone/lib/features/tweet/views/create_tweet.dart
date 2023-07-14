import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/theme/pallet.dart';

class CreateTweet extends ConsumerStatefulWidget {
  const CreateTweet({Key? key}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const CreateTweet());
  }

  @override
  ConsumerState<CreateTweet> createState() => _CreateTweetState();
}

class _CreateTweetState extends ConsumerState<CreateTweet> {
  // onClose go home screen

  onClose() {
    Navigator.push(context, HomeView.route());
  }

  final tweetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
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
              onTap: () {},
              label: "Tweet",
              bgColor: Pallete.blueColor,
              textColor: Pallete.whiteColor)
        ],
      ),
      body: currentUser == null
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
                  )
                ],
              ),
            )),
    );
  }
}
