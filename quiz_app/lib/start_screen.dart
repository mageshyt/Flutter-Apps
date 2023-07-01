import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // logo image
          const Image(
            image: AssetImage('assets/images/quiz-logo.png'),
            width: 200,
            height: 200,
            color: Color.fromARGB(158, 255, 255, 255),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Quiz App',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
              onPressed: startQuiz,
              label: const Text(
                "start Quiz",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              icon: const Icon(
                Icons.arrow_right_alt_sharp,
                color: Colors.white,
                size: 32,
              ),
            ),
          )
        ],
      ),
    );
  }
}
