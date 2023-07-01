import 'package:flutter/material.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start';

  var score = 0;
  void startQuiz() {
    setState(() {
      activeScreen = 'question';
    });
  }

  void showResult() {
    setState(() {
      activeScreen = 'result';
    });
  }

  void incrementScore() {
    setState(() {
      score++;
    });
  }

  void resetQuiz() {
    setState(() {
      activeScreen = 'start';
      score = 0;
    });
  }

  Map<int, dynamic> resultSummary = {};

  Widget getCurrentScreen() {
    if (activeScreen == 'start') {
      return StartScreen(startQuiz);
    } else if (activeScreen == 'question') {
      return QuestionScreen(showResult, incrementScore, resultSummary);
    } else if (activeScreen == 'result') {
      return ResultScreen(
        score: score,
        resetQuiz: resetQuiz,
        resultSummary: resultSummary,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(219, 0, 0, 0),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.decal,
            ),
          ),
          child: getCurrentScreen(),
        ),
      ),
    );
  }
}
