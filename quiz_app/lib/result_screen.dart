import 'package:flutter/material.dart';
import 'package:quiz_app/components/summary.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final void Function() resetQuiz;
  final Map<int, dynamic> resultSummary;
  const ResultScreen(
      {super.key,
      required this.score,
      required this.resetQuiz,
      required this.resultSummary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "You scored $score out of ${resultSummary.length} 💫",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 20),
        Summary(resultSummary: resultSummary),

        // reset button
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: ElevatedButton(
              onPressed: resetQuiz,
              child: const Text('Reset Quiz'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                primary: Colors.greenAccent,
                elevation: 5,
              )),
        )
      ]),
    );
  }
}
