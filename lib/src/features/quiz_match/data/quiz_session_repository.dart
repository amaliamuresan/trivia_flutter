import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';

class QuizSessionRepository {
  factory QuizSessionRepository() => _singleton;

  QuizSessionRepository._internal() : super();
  static final QuizSessionRepository _singleton = QuizSessionRepository._internal();

  final CollectionReference matchesCollection = FirebaseFirestore.instance.collection('matches');

  Future<String> createMatch({required QuizSession sessionDetails}) async {
    final document = matchesCollection.doc();
    await document.set(sessionDetails.toMap());
    return document.id;
  }

  Future<void> connectToMatch({required bool isChallenger, required String matchId, required String playerId}) async {
    final updateField = isChallenger ? 'challengerConnected' : 'otherPlayerConnected';

    final updateMap = <String, dynamic>{updateField: true};

    await matchesCollection.doc(matchId).update(updateMap);
  }
}
