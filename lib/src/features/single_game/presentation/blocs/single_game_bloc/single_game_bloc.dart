import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trivia_app/src/features/quiz_menu/data/open_trivia_repository.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_question.dart';

part 'single_game_event.dart';
part 'single_game_state.dart';

class SingleGameBloc extends Bloc<SingleGameEvent, SingleGameState> {
  SingleGameBloc(this.categoryId) : super(const SingleGameState()) {
    on<LoadQuestions>(_loadQuestions);
    on<IncrementIndex>(_incrementIndex);
    on<AnswerChosen>(_answerChosen);

    add(LoadQuestions());
  }
  final int categoryId;

  final OpenTriviaRepository _triviaRepository = OpenTriviaRepository();

  Future<FutureOr<void>> _loadQuestions(
    LoadQuestions event,
    Emitter<SingleGameState> emit,
  ) async {
    try {
      final questions =
          await _triviaRepository.getQuestions(categoryId: categoryId);
      if (questions.isNotEmpty) {
        emit(
          state.copyWith(
            questions: questions,
            gameStateEnum: SingleGameStateEnum.gameInProgress,
          ),
        );
      } else {
        emit(state.copyWith(gameStateEnum: SingleGameStateEnum.error));
      }
    } catch (_) {
      emit(state.copyWith(gameStateEnum: SingleGameStateEnum.error));
    }
  }

  FutureOr<void> _incrementIndex(
    IncrementIndex event,
    Emitter<SingleGameState> emit,
  ) {
    if (state.currentIndex == 9) {
      emit(
        state.copyWith(
          gameStateEnum: SingleGameStateEnum.gameFinished,
        ),
      );
    } else {
      emit(
        state.copyWith(
          currentIndex: state.currentIndex + 1,
        ),
      );
    }
  }

  FutureOr<void> _answerChosen(
    AnswerChosen event,
    Emitter<SingleGameState> emit,
  ) {
    var nrOfCorrectAnswers = state.nrOfCorrectAnswers;
    if (event.answer == state.questions[state.currentIndex].correctAnswer) {
      nrOfCorrectAnswers++;
    }
    if (state.currentIndex == 9) {
      emit(
        state.copyWith(
          gameStateEnum: SingleGameStateEnum.gameFinished,
          nrOfCorrectAnswers: nrOfCorrectAnswers,
        ),
      );
    } else {
      emit(
        state.copyWith(
          currentIndex: state.currentIndex + 1,
          nrOfCorrectAnswers: nrOfCorrectAnswers,
        ),
      );
    }
  }
}
