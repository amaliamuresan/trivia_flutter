part of 'manage_friend_requests_bloc.dart';

class ManageFriendRequestsState extends Equatable {
  const ManageFriendRequestsState({
    this.friendRequests = const [],
    this.pageStateEnum = PageStateEnum.loading,
  });

  final List<FirestoreUserPublicData> friendRequests;
  final PageStateEnum pageStateEnum;

  ManageFriendRequestsState copyWith({
    List<FirestoreUserPublicData>? friendRequests,
    PageStateEnum? pageStateEnum,
  }) {
    return ManageFriendRequestsState(
      friendRequests: friendRequests ?? this.friendRequests,
      pageStateEnum: pageStateEnum ?? this.pageStateEnum,
    );
  }

  @override
  List<Object?> get props => [friendRequests, pageStateEnum];
}
