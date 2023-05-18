import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:trivia_app/src/features/authentication/domain/models/auth_user_data.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/quiz_match/data/quiz_session_repository.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';

class QuizMatchScreen extends StatefulWidget {
  const QuizMatchScreen({
    required this.matchId,
    required this.isChallenger,
    super.key,
  });

  final String matchId;
  final bool isChallenger;

  @override
  State<QuizMatchScreen> createState() => _QuizMatchScreenState();
}

class _QuizMatchScreenState extends State<QuizMatchScreen> {
  late bool isLoading;
  late QuizSession session;
  late AuthUserData currentUser;
  late final StreamSubscription<DocumentSnapshot<Object?>> matchSubscription;

  @override
  void initState() {
    super.initState();
    currentUser = BlocProvider.of<AuthBloc>(context).state.authUserData;
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(widget.isChallenger);
      print(widget.matchId);
      print(currentUser.id);
      await QuizSessionRepository().connectToMatch(
        isChallenger: widget.isChallenger,
        matchId: widget.matchId,
        playerId: currentUser.id,
      );

      matchSubscription = QuizSessionRepository().matchesCollection.doc(widget.matchId).snapshots().listen((event) {
        final sessionData = event.data() as Map<String, dynamic>;
        setState(() {
          isLoading = false;
          session = QuizSession.fromMap(sessionData);
        });
      });
    });
  }

  @override
  void dispose() {
    matchSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!session.challengerConnected || !session.otherPlayerConnected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          const Text(
            'Waiting for other player...',
            style: TextStyle(color: Colors.white),
          ),
          const CircularProgressIndicator(),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Text(
          session.category,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          _convertHtmlText(session.questions[session.currentQuestionIndex].question),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 40,
          width: double.infinity,
          color: Colors.red,
          child: Center(
            child: Text(
              _convertHtmlText(session.questions[session.currentQuestionIndex].correctAnswer),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ...session.questions[session.currentQuestionIndex].incorrectAnswers.map(
          (answer) => Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                color: Colors.red,
                child: Center(
                  child: Text(
                    _convertHtmlText(answer),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _convertHtmlText(String htmlText) {
  return parse(htmlText).body!.text;
}
