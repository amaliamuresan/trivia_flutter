import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_public_repository.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/quiz_match/data/quiz_session_repository.dart';
import 'package:trivia_app/src/features/quiz_match/domain/quiz_session.dart';
import 'package:trivia_app/src/features/quiz_menu/data/open_trivia_repository.dart';
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
  late FirestoreUserPublicData debugUser;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugUser = await FirestoreUserPublicRepository().getUserPublicDataById('EPMxezSBUdNr5Nuvln8xLMBWLNm1');
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is category: ${widget.category.name}'),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final currentUser = BlocProvider.of<AuthBloc>(context).state.authUserData;
                  final questions = await OpenTriviaRepository().getQuestions(categoryId: widget.category.id);
                  final quizMatch = QuizSession(
                    challengerId: currentUser.id,
                    otherPlayerId: debugUser.id,
                    isMatchFinished: false,
                    questions: questions,
                    currentQuestionIndex: 0,
                    challengerRightAnswers: 0,
                    otherPLayerRightAnswers: 0,
                    challengerCurrentResponse: null,
                    otherPlayerCurrentResponse: null,
                    challengerConnected: false,
                    otherPlayerConnected: false,
                    category: widget.category.name,
                  );
                  final matchId = await QuizSessionRepository().createMatch(sessionDetails: quizMatch);
                  print(matchId);
                  context.pushNamed(RouteNames.quizMatch, queryParams: {
                    'matchId': matchId,
                    'isChallenger': 'true',
                  });
                },
                child: Text('Challenge debug user with name: ${debugUser.displayName}!'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
