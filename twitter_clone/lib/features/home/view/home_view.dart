import 'package:flutter/material.dart';
import 'package:twitter_clone/common/bottom_bar.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/views/create_tweet.dart';
import 'package:twitter_clone/theme/pallet.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const HomeView());
  }

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _bottomNavIndex = 0;

  void setActiveTab(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  onCreateTweet() {
    Navigator.push(context, CreateTweet.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UIConstants.appBar(),
        body: IndexedStack(
          index: _bottomNavIndex,
          children: [
            UIConstants.Pages[0],
            UIConstants.Pages[1],
            UIConstants.Pages[2],
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:onCreateTweet,
          backgroundColor: Pallete.blueColor,
          child: const Icon(
            Icons.add,
            color: Pallete.whiteColor,
            size: 30,
          ),
        ),
        bottomNavigationBar:
            BottomBar(bottomNavIndex: _bottomNavIndex, onTap: setActiveTab));
  }
}
