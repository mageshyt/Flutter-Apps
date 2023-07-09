import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
   static route() => MaterialPageRoute(builder: (context) => const HomeView());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: const Text("Home Page"),
      ),
    );
  }
}
