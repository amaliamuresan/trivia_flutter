import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/quiz_match/data/quiz_session_repository.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/style.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

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
    print('init notif state');
    final connectedUserId = BlocProvider.of<AuthBloc>(context).state.authUserData.id;
    matchesSubscription =
        _quizSessionRepository.matchesCollection.where('otherPlayerId', isEqualTo: connectedUserId).snapshots().listen((event) {
      setState(() {
        matches = <QuizSession>[];
        matchesIds = <String>[];
        for (final element in event.docs) {
          final data = element.data();
          matches.add(QuizSession.fromMap(data as Map<String, dynamic>));
          matchesIds.add(element.id);
        }
        matches
          ..add(QuizSession(
              challengerId: 'challengerId',
              otherPlayerId: 'otherPlayerId',
              matchDone: false,
              currentQuestionIndex: 0,
              challengerCorrectAnswers: 0,
              otherPlayerCorrectAnswers: 0,
              challengerAnswer: 'challengerAnswer',
              otherPlayerAnswer: 'otherPlayerAnswer',
              challengerConnected: true,
              otherPlayerConnected: true,
              category: 'General Knowledge',
              categoryId: 22))
          ..add(QuizSession(
              challengerId: 'challengerId',
              otherPlayerId: 'otherPlayerId',
              matchDone: false,
              currentQuestionIndex: 0,
              challengerCorrectAnswers: 0,
              otherPlayerCorrectAnswers: 0,
              challengerAnswer: 'challengerAnswer',
              otherPlayerAnswer: 'otherPlayerAnswer',
              challengerConnected: true,
              otherPlayerConnected: true,
              category: 'Entertainment: Music',
              categoryId: 22));
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
    return Padding(
      padding: const EdgeInsets.all(AppMargins.smallMargin),
      child: matches.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Challenge in ${matches[index].category}'),
                        CustomButton.primary(
                          width: 100,
                          height: 45,
                          onPressed: () {
                            context.pushNamed(RouteNames.quizMatch, queryParams: {
                              'matchId': matchesIds[index],
                              'isChallenger': 'false',
                            });
                          },
                          text: 'Accept',
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: AppMargins.smallMargin);
              },
            )
          : const Center(child: Text('No challenges!')),
    );
  }
}
