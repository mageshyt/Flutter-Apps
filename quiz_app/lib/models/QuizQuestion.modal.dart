class QuizQuestion {
  final String question;
  final List<String> answers;
  final  String correctAnswer;

  const QuizQuestion(this.question, this.answers,this.correctAnswer);


  get options => null;

  // shuffle the answers
  getShuffledOptions() {
    final shuffledAnswers = List.of(answers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}
