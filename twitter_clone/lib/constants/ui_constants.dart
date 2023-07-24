import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/theme/pallet.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        height: 30,
        color: Pallete.blueColor,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> Pages = [
    Container(child: Text("Home Page")),
    Container(child: Text("Search Page")),
    Container(child: Text("Notification Page")),
  ];
}
