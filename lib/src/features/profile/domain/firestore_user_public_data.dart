import 'package:equatable/equatable.dart';

class FirestoreUserPublicData extends Equatable {
  const FirestoreUserPublicData({
    required this.id,
    this.nrOfMatchesPlayed,
    this.nrOfMatchesWon,
    this.friendsUids,
    this.displayName,
    this.photoUrl,
  });

  FirestoreUserPublicData.fromJson(Map<String, dynamic> json, this.id)
      : photoUrl = json['photoUrl'] as String?,
        displayName = json['displayName'] as String,
        friendsUids = (json['friendsUids'] as List?)?.map((e) => e as String).toList(),
        nrOfMatchesWon = json['nrOfMatchesWon'] as int?,
        nrOfMatchesPlayed = json['nrOfMatchesPlayed'] as int?;

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'nrOfMatchesPlayed': nrOfMatchesPlayed,
        'nrOfMatchesWon': nrOfMatchesWon,
        'friendsUids': friendsUids,
        'photoUrl': photoUrl,
      };

  final String id;

  final String? displayName;

  final String? photoUrl;

  final int? nrOfMatchesPlayed;

  final int? nrOfMatchesWon;

  final List<String>? friendsUids;

  static const FirestoreUserPublicData empty = FirestoreUserPublicData(id: '');

  bool get isEmpty => this == FirestoreUserPublicData.empty;

  bool get isNotEmpty => this != FirestoreUserPublicData.empty;

  @override
  List<Object?> get props => <Object?>[id, displayName, photoUrl, nrOfMatchesPlayed, nrOfMatchesWon, friendsUids];
}
