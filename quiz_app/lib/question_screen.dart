import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/Button.dart';
import 'package:quiz_app/data/question.data.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var questions = questionsData;
  var questionIndex = 1;
  Map<dynamic, dynamic> mapName = {};
  void nextQuestion() {
    setState(() {
      questionIndex++;
    });
  }

  void answerQuestion(String option) {
    if (questionIndex < questions.length) {
      mapName[questionIndex] = option;
      nextQuestion();
    } else {
      if (kDebugMode) {
        print(mapName);
        print('Quiz completed!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question $questionIndex',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 350,
            child: Text(
              questions[questionIndex - 1].question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              for (var option in questions[questionIndex - 1].answers)
                Button(
                  color: Colors.white,
                  label: option,
                  handleClick: answerQuestion,
                ),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: questionIndex == questions.length ? 50 : 0,
            width: questionIndex == questions.length ? 150 : 0,
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                // Handle Result View button click
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Result View',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
