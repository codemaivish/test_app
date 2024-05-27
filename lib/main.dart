import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:test_app/quizz_question.dart';
import 'package:test_app/quizz_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Question> questions =
      await loadQuestionsFromJsonFile('assets/question.json');
  runApp(MyApp(questions: questions));
}

class MyApp extends StatelessWidget {
  final List<Question> questions;

  MyApp({required this.questions});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: QuizScreen(questions: questions), // Correct instantiation
      ),
    );
  }
}

Future<List<Question>> loadQuestionsFromJsonFile(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  List<dynamic> jsonData = jsonDecode(jsonString);
  List<Question> questions =
      jsonData.map((data) => Question.fromJson(data)).toList();
  return questions;
}
