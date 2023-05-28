import 'package:trivia_app/src/features/quiz_menu/domain/quiz_match_question.dart';

class QuizSession {
  QuizSession({
    required this.challengerId,
    required this.otherPlayerId,
    required this.matchDone,
    this.currentQuestion,
    // required this.questions,
    required this.currentQuestionIndex,
    required this.challengerCorrectAnswers,
    required this.otherPlayerCorrectAnswers,
    required this.challengerAnswer,
    required this.otherPlayerAnswer,
    required this.challengerConnected,
    required this.otherPlayerConnected,
    required this.category,
    required this.categoryId,
  });

  factory QuizSession.fromMap(Map<String, dynamic> map) {
    return QuizSession(
      challengerId: map['challengerId'] as String,
      category: map['category'] as String,
      categoryId: map['categoryId'] as int,
      otherPlayerId: map['otherPlayerId'] as String,
      matchDone: map['matchDone'] as bool?,
      // questions: QuizQuestion.fromList(map['questions'] as List),
      currentQuestionIndex: map['currentQuestionIndex'] as int,
      currentQuestion: map['current_question'] != null
          ? QuizMatchQuestion.fromMap(map['current_question'] as Map<String, dynamic>)
          : null,
      challengerCorrectAnswers: map['challengerCorrectAnswers'] as int,
      otherPlayerCorrectAnswers: map['otherPlayerCorrectAnswers'] as int,
      challengerAnswer: map['challengerAnswer'] as String?,
      otherPlayerAnswer: map['otherPlayerAnswer'] as String?,
      challengerConnected: map['challengerConnected'] as bool,
      otherPlayerConnected: map['otherPlayerConnected'] as bool,
    );
  }

  String category;
  int categoryId;

  bool challengerConnected;
  bool otherPlayerConnected;

  String challengerId;
  String otherPlayerId;
  bool? matchDone;

  // List<QuizQuestion> questions;
  QuizMatchQuestion? currentQuestion;
  int currentQuestionIndex;

  int challengerCorrectAnswers;
  int otherPlayerCorrectAnswers;

  String? challengerAnswer;
  String? otherPlayerAnswer;

  Map<String, dynamic> toMap() {
    return {
      'challengerId': challengerId,
      'category': category,
      'categoryId': categoryId,
      'otherPlayerId': otherPlayerId,
      'matchDone': matchDone,
      'currentQuestion': currentQuestion,
      // 'questions': questions.map((e) => e.toMap()).toList(),
      'currentQuestionIndex': currentQuestionIndex,
      'challengerCorrectAnswers': challengerCorrectAnswers,
      'otherPlayerCorrectAnswers': otherPlayerCorrectAnswers,
      'challengerAnswer': challengerAnswer,
      'otherPlayerAnswer': otherPlayerAnswer,
      'challengerConnected': challengerConnected,
      'otherPlayerConnected': otherPlayerConnected,
    };
  }
// DateTime? challengerHeartbeat;
  // DateTime? otherPlayerHeartbeat;
}
