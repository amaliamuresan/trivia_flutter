import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';

class QuizSessionRepository {
  factory QuizSessionRepository() => _singleton;

  QuizSessionRepository._internal() : super();
  static final QuizSessionRepository _singleton = QuizSessionRepository._internal();

  final CollectionReference matchesCollection = FirebaseFirestore.instance.collection('matches');

  Future<String> createMatch({
    required String challengerId,
    required String opponentId,
    required QuizCategory category,
  }) async {
    final session = QuizSession(
      challengerId: challengerId,
      otherPlayerId: opponentId,
      matchDone: false,
      // questions: questions,
      currentQuestionIndex: 0,
      challengerCorrectAnswers: 0,
      otherPlayerCorrectAnswers: 0,
      challengerAnswer: null,
      otherPlayerAnswer: null,
      challengerConnected: false,
      otherPlayerConnected: false,
      category: category.name,
      categoryId: category.id,
    );

    final document = matchesCollection.doc();
    await document.set(session.toMap());
    return document.id;
  }

  Future<void> connectToMatch({required bool isChallenger, required String matchId, required String playerId}) async {
    final updateField = isChallenger ? 'challengerConnected' : 'otherPlayerConnected';

    final updateMap = <String, dynamic>{updateField: true};

    await matchesCollection.doc(matchId).update(updateMap);
  }

  Future<void> answerQuestion({required bool isChallenger, required String matchId, required String answer}) async {
    final updateField = isChallenger ? 'challengerAnswer' : 'otherPlayerAnswer';

    final updateMap = <String, dynamic>{updateField: answer};

    await matchesCollection.doc(matchId).update(updateMap);
  }
}
