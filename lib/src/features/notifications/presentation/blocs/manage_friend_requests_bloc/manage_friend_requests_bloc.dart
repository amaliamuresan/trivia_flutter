import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trivia_app/src/enums/page_state_enum.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/profile/domain/user_data_service.dart';

part 'manage_friend_requests_event.dart';
part 'manage_friend_requests_state.dart';

class ManageFriendRequestsBloc extends Bloc<ManageFriendRequestsEvent, ManageFriendRequestsState> {
  ManageFriendRequestsBloc(this._loggedUserId) : super(const ManageFriendRequestsState()) {
    on<DenyPressed>(_denyPressed);
    on<AcceptPressed>(_acceptPressed);
    on<GetInitialFriendRequests>(_getInitialRequests);

    add(GetInitialFriendRequests());
  }

  final String _loggedUserId;
  final UserDataService _userDataService = UserDataService();

  Future<FutureOr<void>> _denyPressed(DenyPressed event, Emitter<ManageFriendRequestsState> emit) async {
    try {
      await _userDataService.denyFriendRequest(event.uid, _loggedUserId);
      print(state.friendRequests);
      state.friendRequests.removeWhere((e) => e.id == event.uid);
      final newRequests = state.friendRequests;
      print(newRequests);
      emit(state.copyWith(friendRequests: newRequests, pageStateEnum: PageStateEnum.loaded));
    } catch(e) {
      emit(state.copyWith(pageStateEnum: PageStateEnum.error));
    }
  }

  Future<FutureOr<void>> _acceptPressed(AcceptPressed event, Emitter<ManageFriendRequestsState> emit) async {
    try {
      print("accept pressed");
      await _userDataService.acceptFriendRequest(event.uid, _loggedUserId);
      state.friendRequests.removeWhere((e) => e.id == event.uid);
      final newRequests = state.friendRequests;
      emit(state.copyWith(friendRequests: newRequests, pageStateEnum: PageStateEnum.loaded));
    } catch(e) {
      emit(state.copyWith(pageStateEnum: PageStateEnum.error));
    }
  }

  Future<FutureOr<void>> _getInitialRequests(GetInitialFriendRequests event, Emitter<ManageFriendRequestsState> emit) async {
    try {
      final requests = await _userDataService.getFriendsRequests(_loggedUserId);
      emit(state.copyWith(friendRequests: requests, pageStateEnum: PageStateEnum.loaded));
    } catch(e) {
      emit(state.copyWith(pageStateEnum: PageStateEnum.error));
    }
  }
}
