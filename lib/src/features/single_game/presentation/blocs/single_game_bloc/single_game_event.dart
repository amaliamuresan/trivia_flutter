part of 'single_game_bloc.dart';

@immutable
abstract class SingleGameEvent {}

class LoadQuestions extends SingleGameEvent {}

class IncrementIndex extends SingleGameEvent {}

class AnswerChosen extends SingleGameEvent {
  AnswerChosen(this.answer);

  final String? answer;
}
