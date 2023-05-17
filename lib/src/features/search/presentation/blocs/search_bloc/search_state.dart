part of 'search_bloc.dart';

enum SearchStateEnum { initial, loading, data, error, noData }

class SearchState extends Equatable {
  const SearchState({
    this.users,
    this.searchState = SearchStateEnum.initial,
  });

  final SearchStateEnum searchState;
  final List<FirestoreUserPublicData>? users;

  @override
  List<Object?> get props => [users, searchState];

  SearchState copyWith({
    SearchStateEnum? searchState,
    List<FirestoreUserPublicData>? users,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      users: users ?? this.users,
    );
  }
}
