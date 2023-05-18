import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/quiz_match/data/quiz_session_repository.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';
import 'package:trivia_app/src/routes/routes.dart';

class TempNotificationChallenges extends StatefulWidget {
  const TempNotificationChallenges({super.key});

  @override
  State<TempNotificationChallenges> createState() => _TempNotificationChallengesState();
}

class _TempNotificationChallengesState extends State<TempNotificationChallenges> {
  late bool isLoading;
  List<QuizSession> matches = <QuizSession>[];
  List<String> matchesIds = <String>[];
  final QuizSessionRepository _quizSessionRepository = QuizSessionRepository();
  late final StreamSubscription<QuerySnapshot<Object?>> matchesSubscription;

  @override
  void initState() {
    super.initState();
    final connectedUserId = BlocProvider.of<AuthBloc>(context).state.authUserData.id;
    matchesSubscription = _quizSessionRepository.matchesCollection
        .where('otherPlayerId', isEqualTo: connectedUserId)
        .snapshots()
        .listen((event) {
      setState(() {
        matches = <QuizSession>[];
        matchesIds = <String>[];
        for (final element in event.docs) {
          final data = element.data();
          matches.add(QuizSession.fromMap(data as Map<String, dynamic>));
          matchesIds.add(element.id);
        }
      });
    });
  }

  @override
  void dispose() {
    matchesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 40,
          child: Row(
            children: [
              Text('Challenge in ${matches[index].category}'),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouteNames.quizMatch, queryParams: {
                    'matchId': matchesIds[index],
                    'isChallenger': 'false',
                  });
                },
                child: const Text('Play match'),
              ),
            ],
          ),
        );
      },
    );
  }
}
