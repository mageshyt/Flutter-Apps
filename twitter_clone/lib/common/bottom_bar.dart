import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallet.dart';

class BottomBar extends StatelessWidget {
  final void Function(int) onTap;

  final int bottomNavIndex;
  BottomBar({
    Key? key,
    required this.bottomNavIndex,
    required this.onTap,
  }) : super(key: key);

  final _icons = [
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.chat,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: _icons,
      activeColor: Pallete.blueColor,
      activeIndex: bottomNavIndex,
      gapLocation: GapLocation.none,
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      inactiveColor: Colors.white,
      notchSmoothness: NotchSmoothness.defaultEdge,
      iconSize: 29,
      height: 60,
      onTap: (index) => onTap(index),
    );
  }
}
