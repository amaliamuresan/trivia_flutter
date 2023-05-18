part of 'friend_request_bloc.dart';

class FriendRequestState extends Equatable {
  const FriendRequestState(
      {this.isFriendRequestSent = false, this.isLoading = true});

  final bool isFriendRequestSent;
  final bool isLoading;

  FriendRequestState copyWith({bool? isFriendRequestSent, bool? isLoading}) {
    return FriendRequestState(
      isFriendRequestSent: isFriendRequestSent ?? this.isFriendRequestSent,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isFriendRequestSent, isLoading];
}
