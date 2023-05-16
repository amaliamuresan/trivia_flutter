import 'package:html/parser.dart';

class QuizQuestion {
  const QuizQuestion({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      category: _convertHtmlText(map['category'] as String),
      type: _convertHtmlText(map['type'] as String),
      difficulty: _convertHtmlText(map['difficulty'] as String),
      question: _convertHtmlText(map['question'] as String),
      correctAnswer: _convertHtmlText(map['correct_answer'] as String),
      incorrectAnswers: (map['incorrect_answers'] as List).map((e) => _convertHtmlText(e as String)).toList(),
    );
  }

  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  static List<QuizQuestion> fromList(List<dynamic> list) {
    final categories = <QuizQuestion>[];
    for (final dynamic element in list) {
      categories.add(QuizQuestion.fromMap(element as Map<String, dynamic>));
    }
    return categories;
  }

  static String _convertHtmlText(String htmlText) {
    return parse(htmlText).body!.text;
  }

  @override
  String toString() {
    return 'QuizQuestion{category: $category, type: $type, difficulty: $difficulty, question: $question, correctAnswer: $correctAnswer, incorrectAnswers: $incorrectAnswers}';
  }
}
