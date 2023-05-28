part of 'manage_friend_requests_bloc.dart';

@immutable
abstract class ManageFriendRequestsEvent {

}

class DenyPressed extends ManageFriendRequestsEvent {
  DenyPressed(this.uid);

  final String uid;
}

class AcceptPressed extends ManageFriendRequestsEvent {
  AcceptPressed(this.uid);

  final String uid;
}

class GetInitialFriendRequests extends ManageFriendRequestsEvent {

}
