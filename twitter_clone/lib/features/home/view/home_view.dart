import 'package:flutter/material.dart';
import 'package:twitter_clone/common/bottom_bar.dart';
import 'package:twitter_clone/constants/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UIConstants.appBar(),
        body: IndexedStack(
          index: _bottomNavIndex,
          children: [
            Container(color: Colors.black),
            Container(color: Colors.green),
            Container(color: Colors.blue),
            Container(color: Colors.yellow),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar:
            BottomBar(bottomNavIndex: _bottomNavIndex, onTap: setActiveTab));
  }
}
