import 'package:flutter/material.dart';
import 'package:quiz_app/components/Button.dart';

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
            color: Color.fromARGB(109, 255, 255, 255),
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

          Button(
            color: Colors.black,
            label: 'Start Quiz',
            handleClick: startQuiz,
          ),
        ],
      ),
    );
  }
}
