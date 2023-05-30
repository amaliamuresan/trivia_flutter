import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';

class FirestoreUserPublicRepository {
  factory FirestoreUserPublicRepository() => _singleton;

  FirestoreUserPublicRepository._internal() : super();

  static final FirestoreUserPublicRepository _singleton =
      FirestoreUserPublicRepository._internal();

  final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection('userPublicData');

  Future<void> addData(FirestoreUserPublicData userData) async {
    try {
      await _collectionReference.doc(userData.id).set(userData.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('addData $e');
      }
    }
  }

  Future<List<FirestoreUserPublicData>?> getUsersPublicDataByIds(
    List<String> ids,
  ) async {
    try {
      final users = List<FirestoreUserPublicData>.empty(growable: true);
      for (final i in ids) {
        final user = await getUserPublicDataById(i);
        users.add(user);
      }
      return users;
    } catch (e) {
      if (kDebugMode) {
        print('getUsersPublicDataByIds $e');
      }
    }
    return null;
  }

  Future<FirestoreUserPublicData> getUserPublicDataById(String userId) async {
    final snapshot = await _collectionReference.doc(userId).get();
    final body = snapshot.data()!;
    return FirestoreUserPublicData.fromJson(body, userId);
  }

  Future<List<FirestoreUserPublicData>?> getUserByDisplayName(
      String displayName) async {
    try {
      final QuerySnapshot data = await _collectionReference
          .where('displayName', isGreaterThanOrEqualTo: displayName)
          .where('displayName', isLessThan: '${displayName}z')
          .get();
      if (data.docs.isNotEmpty) {
        return _mapUserPublicDataFromSnapshot(data.docs);
      }
    } catch (e) {
      if (kDebugMode) {
        print('AuthService $e');
      }
    }
    return null;
  }

  Future<void> updateProfilePictureUrl(String uid, String photoUrl) async {
    await _collectionReference.doc(uid).update({'photoUrl': photoUrl});
  }

  Future<void> addFriend(String uid1, String uid2) async {
    try {
      await _collectionReference.doc(uid1).update({
        'friendsUids': FieldValue.arrayUnion([uid2])
      });
      await _collectionReference.doc(uid2).update({
        'friendsUids': FieldValue.arrayUnion([uid1])
      });
    } catch (e) {
      if (kDebugMode) {
        print('addFriend $e');
      }
    }
  }

  List<FirestoreUserPublicData> _mapUserPublicDataFromSnapshot(
    List<QueryDocumentSnapshot> snapshot,
  ) {
    return snapshot.map((docSnapshot) {
      final json = docSnapshot.data() as Map<String, dynamic>?;
      if (json != null) {
        return FirestoreUserPublicData.fromJson(json, docSnapshot.id);
      } else {
        return FirestoreUserPublicData.empty;
      }
    }).toList();
  }

  void listenUserDataChange(
    String uid,
    void Function(FirestoreUserPublicData) onDataChanged,
  ) {
    if (uid.isNotEmpty) {
      _collectionReference.doc(uid).snapshots().listen(
        (docSnapshot) {
          if (docSnapshot.exists && docSnapshot.data() != null) {
            onDataChanged(
              FirestoreUserPublicData.fromJson(docSnapshot.data()!, uid),
            );
          }
        },
      );
    }
  }
}
