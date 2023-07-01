import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final Map<int, dynamic> resultSummary;
  const Summary({Key? key, required this.resultSummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: resultSummary.entries
              .map((e) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Indicator(
                        userAnswer: e.value['answer'],
                        correctAnswer: e.value['correctAnswer'],
                        index: e.key,
                      ),

                      // question
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              e.value['question'],
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            // correct answer
                            Text(
                              e.value['correctAnswer'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),

                            // user answer

                            Text(
                              e.value['answer'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String userAnswer;
  final String correctAnswer;
  final int index;
  const Indicator(
      {Key? key,
      required this.userAnswer,
      required this.correctAnswer,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: userAnswer == correctAnswer
                ? Colors.pinkAccent
                : Colors.purpleAccent,
            borderRadius: BorderRadius.circular(50)),
        child: Text(index.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)));
  }
}
