import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';
import 'package:trivia_app/src/features/single_game/presentation/blocs/single_game_bloc/single_game_bloc.dart';
import 'package:trivia_app/src/features/single_game/presentation/widgets/game_loading_widget.dart';
import 'package:trivia_app/src/features/single_game/presentation/widgets/game_results_widget.dart';
import 'package:trivia_app/src/features/single_game/presentation/widgets/question_widget.dart';
import 'package:trivia_app/src/style/style.dart';

class SingleGamePage extends StatelessWidget {
  const SingleGamePage({super.key, required this.quizCategory});

  final QuizCategory quizCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingleGameBloc(quizCategory.id),
      child: BlocBuilder<SingleGameBloc, SingleGameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(quizCategory.name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppMargins.regularMargin),
              child: Center(child: getWidgetByState(state, context)),
            ),
          );
        },
      ),
    );
  }

  Widget getWidgetByState(SingleGameState state, BuildContext context) {
    switch (state.gameStateEnum) {
      case SingleGameStateEnum.questionsLoading:
        return GameLoadingWidget(categoryName: quizCategory.name);
      case SingleGameStateEnum.error:
        return const Center(child: Text('Something went wrong!'));
      case SingleGameStateEnum.gameInProgress:
        return QuestionWidget(
          question: state.questions[state.currentIndex],
          onAnswerChosen: (answer) {
            context.read<SingleGameBloc>().add(AnswerChosen(answer));
          },
        );
      case SingleGameStateEnum.gameFinished:
        return GameResultsWidget(
          categoryName: quizCategory.name,
          nrOfCorrectAnswers: state.nrOfCorrectAnswers,
        );
    }
  }
}
