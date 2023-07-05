import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/assets_constants.dart';

class ReuseableAppBar extends StatelessWidget {
  const ReuseableAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: SvgPicture.asset(AssetsConstants.twitterLogo));
  }
}
