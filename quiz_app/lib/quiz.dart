import 'package:flutter/material.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start';

  void startQuiz() {
    setState(() {
      activeScreen = 'question';
    });
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
                Color.fromARGB(198, 0, 0, 0),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.decal,
            ),
          ),
          child: activeScreen == 'start'
              ? StartScreen(startQuiz)
              : const QuestionScreen(),
        ),
      ),
    );
  }
}
