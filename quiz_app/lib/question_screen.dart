import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/components/Button.dart';
import 'package:quiz_app/data/question.data.dart';

class QuestionScreen extends StatefulWidget {
  final void Function() resultScreen;

  final void Function() incrementScore;

  final Map<int, dynamic> resultSummary;
  const QuestionScreen(
    this.resultScreen,
    this.incrementScore,
    this.resultSummary, {
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var questions = questionsData;
  var questionIndex = 0;

  // ignore: non_constant_identifier_names
  var no_of_questions_answered = 0;

  Map<dynamic, dynamic> resultMap = {};
  void nextQuestion() {
    setState(() {
      questionIndex++;
    });
  }

  void answerQuestion(String option) {
    if (no_of_questions_answered < questions.length) {
      widget.resultSummary[questionIndex] = {
        'question': questions[questionIndex].question,
        'answer': option,
        'correctAnswer': questions[questionIndex].correctAnswer,
      };

      setState(() {
        no_of_questions_answered++;
      });

      // check if answer is correct
      if (questions[questionIndex].correctAnswer == option) {
        widget.incrementScore();
      }
    }

    if (questionIndex < questions.length - 1) {
      nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${questionIndex + 1}',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              questions[questionIndex].question,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                ...questions[questionIndex].getShuffledOptions().map(
                      (option) => Button(
                        color: Colors.white,
                        label: option,
                        handleClick: answerQuestion,
                      ),
                    ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeIn,
              height: no_of_questions_answered == questions.length ? 50 : 0,
              width: no_of_questions_answered == questions.length ? 150 : 0,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: widget.resultScreen,
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
      ),
    );
  }
}
