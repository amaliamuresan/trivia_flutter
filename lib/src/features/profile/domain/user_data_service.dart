import 'package:trivia_app/src/features/profile/data/firestore_user_private_repository.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_public_repository.dart';

import 'firestore_user_public_data.dart';

class UserDataService {
  factory UserDataService() => _singleton;

  UserDataService._internal() : super();

  static final UserDataService _singleton = UserDataService._internal();

  final _privateDataRepository = FirestoreUserPrivateRepository();
  final _publicDataRepository = FirestoreUserPublicRepository();

  Future<List<FirestoreUserPublicData>?> getFriendsRequests(String uid) async {
    final privateData = await _privateDataRepository.getUserDataById(uid);
    if (privateData == null) return null;
    final friendRequestsUids = privateData.receivedFriendRequests;
    if (friendRequestsUids != null && friendRequestsUids.isNotEmpty) {
      final userPublicData = await _publicDataRepository
          .getUsersPublicDataByIds(friendRequestsUids);
      return userPublicData;
    }
    return null;
  }
}
