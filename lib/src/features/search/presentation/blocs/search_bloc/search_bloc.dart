import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_public_repository.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchUser>(_searchUser);
  }

  final _repository = FirestoreUserPublicRepository();

  Future<FutureOr<void>> _searchUser(
      SearchUser event, Emitter<SearchState> emit) async {
    emit(state.copyWith(searchState: SearchStateEnum.loading));
    try {
      final users = await _repository.getUserByDisplayName(event.displayName);
      if (users != null && users.isNotEmpty) {
        emit(state.copyWith(users: users, searchState: SearchStateEnum.data));
      } else {
        emit(state.copyWith(searchState: SearchStateEnum.noData));
      }
    } catch (e) {
      emit(state.copyWith(searchState: SearchStateEnum.error));
      if (kDebugMode) {
        print('search user $e');
      }
    }
  }
}
