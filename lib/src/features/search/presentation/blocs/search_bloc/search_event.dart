part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchUser extends SearchEvent {
  SearchUser(this.displayName);

  final String displayName;
}
