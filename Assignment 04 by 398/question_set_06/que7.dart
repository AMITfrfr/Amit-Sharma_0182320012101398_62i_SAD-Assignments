import 'dart:io';

class Question {
  String question;
  List<String> options;
  int answer;
  Question(this.question, this.options, this.answer);
}

class Quiz {
  List<Question> questions;
  int score = 0;

  Quiz(this.questions);

  void start() {
    print('=== Welcome to the Quiz ===\n');

    for (var q in questions) {
      print(q.question);
      for (int i = 0; i < q.options.length; i++) {
        print('${i + 1}. ${q.options[i]}');
      }

      stdout.write('Your answer: ');
      int? ans = int.tryParse(stdin.readLineSync()!);

      if (ans != null && ans == q.answer) {
        print('Correct!\n');
        score++;
      } else {
        print('Wrong! The correct answer was: ${q.options[q.answer - 1]}\n');
      }
    }

    print('Your final score: $score / ${questions.length}');
  }
}

void main() {
  var quiz = Quiz([
    Question('What is the capital of Bangladesh?', [
      'Dhaka',
      'Sylhet',
      'Chittagong',
      'Rajshahi',
    ], 1),
    Question('What is the value of π (pi) up to 4 decimal places?', [
      '3.1426',
      '3.1416',
      '3.1415',
      '3.1400',
    ], 2),
    Question('What is Sylhet famous for?', [
      'Tea gardens',
      'Textile industry',
      'Shipbuilding',
      'Electronics factories',
    ], 1),
    Question('Which programming language is developed by Google?', [
      'Dart',
      'Java',
      'Swift',
      'Kotlin',
    ], 1),
    Question('Which planet is known as the Red Planet?', [
      'Venus',
      'Mars',
      'Jupiter',
      'Mercury',
    ], 2),
  ]);

  quiz.start();
}