import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:trivia_app/src/extensions/string_extensions.dart';
import 'package:trivia_app/src/features/authentication/domain/models/auth_user_data.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/quiz_match/data/quiz_session_repository.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';
import 'package:trivia_app/src/features/quiz_match/presentation/widgets/match_result_screen.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/style.dart';

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
  static const int questionTimeSeconds = 15;
  late bool isLoading;
  late QuizSession session;
  late AuthUserData currentUser;
  late final StreamSubscription<DocumentSnapshot<Object?>> matchSubscription;
  String? selectedAnswer;
  bool showRoundResults = false;
  Timer? timer;
  int remainingTimeSeconds = questionTimeSeconds;

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

      matchSubscription =
          QuizSessionRepository().matchesCollection.doc(widget.matchId).snapshots().listen((event) async {
        if (event.data() != null) {
          final sessionData = event.data() as Map<String, dynamic>;
          final newSession = QuizSession.fromMap(sessionData);
          if (newSession.otherPlayerConnected &&
              newSession.challengerConnected &&
              newSession.currentQuestionIndex == 0 &&
              newSession.otherPlayerAnswer == null &&
              newSession.challengerAnswer == null) {
            startTimer();
          }
          try {
            if (newSession.currentQuestionIndex != session.currentQuestionIndex) {
              setState(() {
                showRoundResults = true;
              });
              await Future<dynamic>.delayed(const Duration(seconds: 2));
              startTimer();
              selectedAnswer = null;
            }
          } catch (_) {
            print(_);

            /// session is null
          }

          setState(() {
            isLoading = false;
            session = newSession;
            showRoundResults = false;
          });
        }
      });
    });
  }

  void startTimer() {
    print('timer start');
    timer?.cancel();
    remainingTimeSeconds = questionTimeSeconds;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingTimeSeconds == 0) {
        timer.cancel();
        if (selectedAnswer == null) {
          await QuizSessionRepository().answerQuestion(
            isChallenger: widget.isChallenger,
            matchId: widget.matchId,
            answer: '-',
          );
        }
      } else {
        setState(() => remainingTimeSeconds--);
      }
    });
  }

  @override
  void dispose() {
    matchSubscription.cancel();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!session.challengerConnected || !session.otherPlayerConnected || session.currentQuestion == null) {
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
    if (session.matchDone == true) {
      return MatchResultScreen(
        playerCorrectQuestions: _getPlayerScore(session, widget.isChallenger),
        opponentCorrectQuestions: _getOpponentScore(session, widget.isChallenger),
        playerName: currentUser.displayName ?? 'Current user has no name??',
        opponentName: 'The other guy',
        onExitTap: () {
          context.goNamed(RouteNames.home);
        },
      );
    }

    final progressBarWidth = MediaQuery.of(context).size.width / 1.1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppMargins.regularMargin),
        const SizedBox(
          height: 50,
        ),
        Stack(
          children: [
            Container(
              height: 8,
              width: progressBarWidth,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Container(
              height: 8,
              width: remainingTimeSeconds * progressBarWidth / questionTimeSeconds,
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
        Text(
          session.category,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: AppMargins.bigMargin),
        Text(
          session.currentQuestion!.question.convertFromHtmlText(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: selectedAnswer != null
                    ? () {}
                    : () async {
                        await QuizSessionRepository().answerQuestion(
                          isChallenger: widget.isChallenger,
                          matchId: widget.matchId,
                          answer: session.currentQuestion!.answers[index],
                        );
                        setState(() {
                          selectedAnswer = session.currentQuestion!.answers[index];
                        });
                      },
                style: ElevatedButton.styleFrom(
                  shape: showRoundResults &&
                          session.currentQuestion!.answers[index] == session.currentQuestion!.correctAnswer
                      ? RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        )
                      : null,
                  backgroundColor: session.currentQuestion!.answers[index] != selectedAnswer
                      ? !showRoundResults
                          ? AppColors.surface
                          : _getOtherAnswer(session, widget.isChallenger) == session.currentQuestion!.answers[index]
                              ? Colors.indigo
                              : AppColors.surface
                      : !showRoundResults
                          ? Colors.green
                          : _getOtherAnswer(session, widget.isChallenger) == session.currentQuestion!.answers[index]
                              ? Colors.purple
                              : Colors.green,
                ),
                child: Text(session.currentQuestion!.answers[index].convertFromHtmlText()),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: AppMargins.regularMargin);
            },
            itemCount: session.currentQuestion!.answers.length,
          ),
        ),
        // ...session.currentQuestion!.answers.map(
        //   (answer) => Column(
        //     children: [
        //       GestureDetector(
        //         onTap: selectedAnswer != null
        //             ? null
        //             : () async {
        //                 await QuizSessionRepository().answerQuestion(
        //                   isChallenger: widget.isChallenger,
        //                   matchId: widget.matchId,
        //                   answer: answer,
        //                 );
        //                 setState(() {
        //                   selectedAnswer = answer;
        //                 });
        //               },
        //         child: Container(
        //           height: 40,
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             color: answer != selectedAnswer
        //                 ? !showRoundResults
        //                     ? Colors.red
        //                     : _getOtherAnswer(session, widget.isChallenger) == answer
        //                         ? Colors.indigo
        //                         : Colors.red
        //                 : !showRoundResults
        //                     ? Colors.green
        //                     : _getOtherAnswer(session, widget.isChallenger) == answer
        //                         ? Colors.purple
        //                         : Colors.green,
        //             border: showRoundResults && answer == session.currentQuestion!.correctAnswer
        //                 ? Border.all(color: Colors.blue, width: 3)
        //                 : null,
        //           ),
        //           child: Center(
        //             child: Text(
        //               _convertHtmlText(answer),
        //               style: const TextStyle(color: Colors.white),
        //             ),
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

String _convertHtmlText(String htmlText) {
  return parse(htmlText).body!.text;
}

String? _getOtherAnswer(QuizSession session, bool isChallenger) {
  return isChallenger ? session.otherPlayerAnswer : session.challengerAnswer;
}

int _getPlayerScore(QuizSession session, bool isChallenger) {
  return isChallenger ? session.challengerCorrectAnswers : session.otherPlayerCorrectAnswers;
}

int _getOpponentScore(QuizSession session, bool isChallenger) {
  return isChallenger ? session.otherPlayerCorrectAnswers : session.challengerCorrectAnswers;
}
