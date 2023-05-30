import 'package:html/parser.dart';

class QuizMatchQuestion {
  const QuizMatchQuestion({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory QuizMatchQuestion.fromMap(Map<String, dynamic> map) {
    return QuizMatchQuestion(
      category: map['category'] as String,
      type: map['type'] as String,
      difficulty: map['difficulty'] as String,
      question: map['question'] as String,
      correctAnswer: map['correctAnswer'] as String,
      answers: (map['answers'] as List).map((e) => e as String).toList(),
    );
  }

  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> answers;

  static List<QuizMatchQuestion> fromList(List<dynamic> list) {
    final categories = <QuizMatchQuestion>[];
    for (final dynamic element in list) {
      categories.add(QuizMatchQuestion.fromMap(element as Map<String, dynamic>));
    }
    return categories;
  }

  static String _convertHtmlText(String htmlText) {
    return parse(htmlText).body!.text;
  }

  @override
  String toString() {
    return 'QuizQuestion{category: $category, type: $type, difficulty: $difficulty, question: $question, answers: $answers}';
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }
}
