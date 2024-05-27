import 'dart:convert';

class Question {
  final String type;
  final List<dynamic> options;
  final String question;
  final List<String>? extraWords;

  Question({
    required this.type,
    required this.options,
    required this.question,
    this.extraWords,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      options: json['options'],
      question: json['question'],
      extraWords: json['extra_words'] != null
          ? List<String>.from(json['extra_words'])
          : null,
    );
  }
}

List<Question> loadQuestionsFromJson(String jsonString) {
  final jsonData = jsonDecode(jsonString);
  List<Question> questions = [];

  for (var item in jsonData['questions']) {
    questions.add(Question.fromJson(item));
  }

  return questions;
}
