import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';

class QuizSessionRepository {
  factory QuizSessionRepository() => _singleton;

  QuizSessionRepository._internal() : super();
  static final QuizSessionRepository _singleton = QuizSessionRepository._internal();

  final CollectionReference matchesCollection = FirebaseFirestore.instance.collection('matches');

  Future<void> createMatch({required QuizSession sessionDetails}) async {
    await matchesCollection.doc().set(sessionDetails.toMap());
  }
}
