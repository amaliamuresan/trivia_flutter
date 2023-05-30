part of 'single_game_bloc.dart';

enum SingleGameStateEnum {
  questionsLoading,
  error,
  gameInProgress,
  gameFinished
}

class SingleGameState extends Equatable {
  const SingleGameState(
      {this.questions = const [],
      this.currentIndex = 0,
      this.gameStateEnum = SingleGameStateEnum.questionsLoading,
      this.nrOfCorrectAnswers = 0});

  final List<QuizQuestion> questions;
  final int currentIndex;
  final SingleGameStateEnum gameStateEnum;
  final int nrOfCorrectAnswers;

  SingleGameState copyWith({
    List<QuizQuestion>? questions,
    int? currentIndex,
    SingleGameStateEnum? gameStateEnum,
    int? nrOfCorrectAnswers,
  }) {
    return SingleGameState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      gameStateEnum: gameStateEnum ?? this.gameStateEnum,
      nrOfCorrectAnswers: nrOfCorrectAnswers ?? this.nrOfCorrectAnswers,
    );
  }

  @override
  List<Object?> get props =>
      [questions, currentIndex, gameStateEnum, nrOfCorrectAnswers];
}
