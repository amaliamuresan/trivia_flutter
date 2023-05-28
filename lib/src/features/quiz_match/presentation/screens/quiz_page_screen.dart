import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/domain/models/auth_user_data.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_public_repository.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/quiz_match/data/quiz_session_repository.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';
import 'package:trivia_app/src/routes/routes.dart';

class QuizPageScreen extends StatefulWidget {
  const QuizPageScreen({
    required this.category,
    super.key,
  });

  final QuizCategory category;

  @override
  State<QuizPageScreen> createState() => _QuizPageScreenState();
}

class _QuizPageScreenState extends State<QuizPageScreen> {
  late bool isLoading;
  late List<FirestoreUserPublicData> userFriends;
  late AuthUserData currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = BlocProvider.of<AuthBloc>(context).state.authUserData;
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userFriends = await FirestoreUserPublicRepository().getUserFriendsById(currentUser.id);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('This is category: ${widget.category.name}'),
                SizedBox(
                  height: 10,
                ),
                Text('Select a friend to challenge'),
                SizedBox(
                  height: 10,
                ),
                ...userFriends.map(
                  (user) => GestureDetector(
                    onTap: () async {
                      final matchId = await QuizSessionRepository().createMatch(
                        category: widget.category,
                        challengerId: currentUser.id,
                        opponentId: user.id,
                      );
                      // ignore: use_build_context_synchronously
                      await context.pushNamed(RouteNames.quizMatch, queryParams: {
                        'matchId': matchId,
                        'isChallenger': 'true',
                      });
                    },
                    child: Container(
                      height: 40,
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(user.displayName ?? 'This user has an error with its name'),
                      ),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () async {
                //         final currentUser = BlocProvider.of<AuthBloc>(context).state.authUserData;
                //         // final questions = await OpenTriviaRepository().getQuestions(categoryId: widget.category.id);
                //         final quizMatch = QuizSession(
                //           challengerId: currentUser.id,
                //           otherPlayerId: debugUser.id,
                //           matchDone: false,
                //           // questions: questions,
                //           currentQuestionIndex: 0,
                //           challengerCorrectAnswers: 0,
                //           otherPlayerCorrectAnswers: 0,
                //           challengerAnswer: null,
                //           otherPlayerAnswer: null,
                //           challengerConnected: false,
                //           otherPlayerConnected: false,
                //           category: widget.category.name,
                //           categoryId: widget.category.id,
                //         );
                //         final matchId = await QuizSessionRepository().createMatch(sessionDetails: quizMatch);
                //         print(matchId);
                //         context.pushNamed(RouteNames.quizMatch, queryParams: {
                //           'matchId': matchId,
                //           'isChallenger': 'true',
                //         });
                //       },
                //       child: Text('Challenge debug user with name: ${debugUser.displayName}!'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
