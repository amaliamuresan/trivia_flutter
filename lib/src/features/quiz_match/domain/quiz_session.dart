import 'package:trivia_app/src/features/quiz_menu/domain/quiz_question.dart';

class QuizSession {
  QuizSession({
    required this.challengerId,
    required this.otherPlayerId,
    required this.isMatchFinished,
    required this.questions,
    required this.currentQuestionIndex,
    required this.challengerRightAnswers,
    required this.otherPLayerRightAnswers,
    required this.challengerCurrentResponse,
    required this.otherPlayerCurrentResponse,
    required this.challengerConnected,
    required this.otherPlayerConnected,
    required this.category,
  });

  factory QuizSession.fromMap(Map<String, dynamic> map) {
    return QuizSession(
      challengerId: map['challengerId'] as String,
      category: map['category'] as String,
      otherPlayerId: map['otherPlayerId'] as String,
      isMatchFinished: map['isMatchFinished'] as bool,
      questions: QuizQuestion.fromList(map['questions'] as List),
      currentQuestionIndex: map['currentQuestionIndex'] as int,
      challengerRightAnswers: map['challengerRightAnswers'] as int,
      otherPLayerRightAnswers: map['otherPLayerRightAnswers'] as int,
      challengerCurrentResponse: map['challengerCurrentResponse'] as bool?,
      otherPlayerCurrentResponse: map['otherPlayerCurrentResponse'] as bool?,
      challengerConnected: map['challengerConnected'] as bool,
      otherPlayerConnected: map['otherPlayerConnected'] as bool,
    );
  }

  String category;

  bool challengerConnected;
  bool otherPlayerConnected;

  String challengerId;
  String otherPlayerId;
  bool isMatchFinished;

  List<QuizQuestion> questions;
  int currentQuestionIndex;

  int challengerRightAnswers;
  int otherPLayerRightAnswers;

  bool? challengerCurrentResponse;
  bool? otherPlayerCurrentResponse;

  Map<String, dynamic> toMap() {
    return {
      'challengerId': challengerId,
      'category': category,
      'otherPlayerId': otherPlayerId,
      'isMatchFinished': isMatchFinished,
      'questions': questions.map((e) => e.toMap()).toList(),
      'currentQuestionIndex': currentQuestionIndex,
      'challengerRightAnswers': challengerRightAnswers,
      'otherPLayerRightAnswers': otherPLayerRightAnswers,
      'challengerCurrentResponse': challengerCurrentResponse,
      'otherPlayerCurrentResponse': otherPlayerCurrentResponse,
      'challengerConnected': challengerConnected,
      'otherPlayerConnected': otherPlayerConnected,
    };
  }
// DateTime? challengerHeartbeat;
  // DateTime? otherPlayerHeartbeat;
}
