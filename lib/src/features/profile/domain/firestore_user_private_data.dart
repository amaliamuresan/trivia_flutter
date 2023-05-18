import 'package:equatable/equatable.dart';

class FirestoreUserPrivateData extends Equatable {
  const FirestoreUserPrivateData({
    this.sentFriendRequests,
    this.receivedFriendRequests,
  });

  FirestoreUserPrivateData.fromJson(Map<String, dynamic> json)
      : receivedFriendRequests = (json['receivedFriendRequests'] as List?)
            ?.map((e) => e as String)
            .toList(),
        sentFriendRequests = (json['sentFriendRequests'] as List?)
            ?.map((e) => e as String)
            .toList();

  Map<String, dynamic> toJson() => {
        'sentFriendRequests': sentFriendRequests,
        'receivedFriendRequests': receivedFriendRequests,
      };

  final List<String>? sentFriendRequests;

  final List<String>? receivedFriendRequests;

  static const FirestoreUserPrivateData empty = FirestoreUserPrivateData();

  bool get isEmpty => this == FirestoreUserPrivateData.empty;

  bool get isNotEmpty => this != FirestoreUserPrivateData.empty;

  @override
  List<Object?> get props =>
      <Object?>[sentFriendRequests, receivedFriendRequests];
}
