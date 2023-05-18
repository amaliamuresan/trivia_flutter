part of 'friend_request_bloc.dart';

@immutable
abstract class FriendRequestEvent {}

class SendFriendRequestPressed extends FriendRequestEvent {}

class CancelFriendRequestPressed extends FriendRequestEvent {}

class VerifyInitialFriendRequestState extends FriendRequestEvent {}
