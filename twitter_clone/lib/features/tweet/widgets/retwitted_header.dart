import 'package:flutter/material.dart';

class ReTwittedHeader extends StatelessWidget {
  final String retweetedBy;
  const ReTwittedHeader({Key? key, required this.retweetedBy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.repeat, color: Colors.grey, size: 15),
        const SizedBox(width: 5),
        Text(
          '$retweetedBy Retweeted',
          style: const TextStyle(
              color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
