import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/core/core.dart';

class FeedPageView extends StatelessWidget {
  const FeedPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          child: const Text('Show Awesome SnackBar'),
          onPressed: () {
            showSnackBar(context, 'This is a message', 'This is a title',
                ContentType.failure);
          }),
    );
  }
}
