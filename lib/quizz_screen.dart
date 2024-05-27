import 'package:flutter/material.dart';
import 'package:test_app/match_question.dart';
import 'package:test_app/quizz_question.dart';

class QuizScreen extends StatelessWidget {
  final List<Question> questions;

  QuizScreen({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          if (question.type == 'match') {
            return MatchQuestion(question: question);
          } else if (question.type == 'translate') {
            // return TranslateQuestion(question: question); // Implement TranslateQuestion widget
            return Container(); // Placeholder for the translate question type
          } else {
            return Container(); // Handle other question types or default case
          }
        },
      ),
    );
  }
}
