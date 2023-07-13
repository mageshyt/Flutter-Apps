// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/theme/pallet.dart';
// import 'package:twitter_clone/theme/pallet.dart';

class BottomBar extends StatelessWidget {
  final void Function(int) onTap;

  final int bottomNavIndex;
  BottomBar({
    Key? key,
    required this.bottomNavIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: Colors.black,
      currentIndex: bottomNavIndex,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
          bottomNavIndex == 0
              ? AssetsConstants.homeFilledIcon
              : AssetsConstants.homeOutlinedIcon,
          color: Pallete.whiteColor,
        )),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
          AssetsConstants.searchIcon,
          color: Pallete.whiteColor,
        )),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
          bottomNavIndex == 2
              ? AssetsConstants.notifFilledIcon
              : AssetsConstants.notifOutlinedIcon,
          color: Pallete.whiteColor,
        )),
      ],
      onTap: onTap,
      activeColor: Pallete.blueColor,
      height: 50,
    );
  }
}
