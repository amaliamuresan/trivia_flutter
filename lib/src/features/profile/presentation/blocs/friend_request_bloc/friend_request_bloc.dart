import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_private_repository.dart';

part 'friend_request_event.dart';
part 'friend_request_state.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  FriendRequestBloc(this.loggedUserId, this.otherUserId)
      : super(const FriendRequestState()) {
    on<VerifyInitialFriendRequestState>(_verifyInitialFriendRequestState);
    on<SendFriendRequestPressed>(_sendFriendRequestPressed);
    on<CancelFriendRequestPressed>(_cancelFriendRequestPressed);
    add(VerifyInitialFriendRequestState());
  }

  final String loggedUserId;
  final String otherUserId;

  final _repository = FirestoreUserPrivateRepository();

  Future<FutureOr<void>> _verifyInitialFriendRequestState(
    VerifyInitialFriendRequestState event,
    Emitter<FriendRequestState> emit,
  ) async {
    final isFriendRequestSent =
        await _repository.isFriendRequestSent(loggedUserId, otherUserId);
    print("isFriendRqsent $isFriendRequestSent");
    emit(
      state.copyWith(
          isLoading: false, isFriendRequestSent: isFriendRequestSent),
    );
  }

  Future<FutureOr<void>> _sendFriendRequestPressed(
    SendFriendRequestPressed event,
    Emitter<FriendRequestState> emit,
  ) async {
    await _repository.sendFriendRequest(loggedUserId, otherUserId);
    emit(state.copyWith(isFriendRequestSent: true));
  }

  Future<FutureOr<void>> _cancelFriendRequestPressed(
    CancelFriendRequestPressed event,
    Emitter<FriendRequestState> emit,
  ) async {
    await _repository.cancelSentFriendRequest(loggedUserId, otherUserId);
    emit(state.copyWith(isFriendRequestSent: false));
  }
}
