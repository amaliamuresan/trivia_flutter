import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_private_data.dart';

class FirestoreUserPrivateRepository {
  factory FirestoreUserPrivateRepository() => _singleton;

  FirestoreUserPrivateRepository._internal() : super();

  static final FirestoreUserPrivateRepository _singleton =
      FirestoreUserPrivateRepository._internal();

  final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection('userPrivateData');

  Future<void> sendFriendRequest(String senderId, String receiverId) async {
    try {
      await _addSentFriendRequest(senderId, receiverId);

      // TODO: to be moved to cloud functions
      await _addReceivedFriendRequest(senderId, receiverId);
    } catch (e) {
      if (kDebugMode) {
        print('sendFriendRequest $e');
      }
    }
  }

  Future<bool> isFriendRequestSent(String loggedUserId, String userId) async {
    try {
      final user = await getUserDataById(loggedUserId);
      print("isreqsent ${user?.sentFriendRequests}");
      if (user == null) return false;
      if (user.sentFriendRequests?.contains(userId) ?? false) return true;
    } catch (e) {
      if (kDebugMode) {
        print('isUserFriend $e');
      }
    }
    return false;
  }

  Future<void> cancelSentFriendRequest(
      String senderId, String receiverId) async {
    try {
      // TODO: to be moved to cloud functions
      await _deleteSentRequest(senderId, receiverId);

      await _deleteReceivedFriendRequest(senderId, receiverId);
    } catch (e) {
      if (kDebugMode) {
        print('cancelSentRequest $e');
      }
    }
  }

  Future<void> removeReceivedFriendRequest(
      String senderId, String receiverId) async {
    try {
      await _deleteReceivedFriendRequest(senderId, receiverId);

      // TODO: to be moved to cloud functions
      await _deleteSentRequest(senderId, receiverId);
    } catch (e) {
      if (kDebugMode) {
        print('removeReceivedRequest $e');
      }
    }
  }

  Future<void> acceptFriendRequest(String senderId, String receiverId) async {
    try {
      await removeReceivedFriendRequest(senderId, receiverId);

      // TODO: to be moved to cloud functions
      await _deleteSentRequest(senderId, receiverId);
    } catch (e) {
      if (kDebugMode) {
        print('removeReceivedRequest $e');
      }
    }
  }

  Future<void> _addSentFriendRequest(String senderId, String receiverId) async {
    final senderDoc = await _collectionReference.doc(senderId).get();
    if (senderDoc.exists) {
      await _collectionReference.doc(senderId).update({
        'sentFriendRequests': FieldValue.arrayUnion([receiverId])
      });
    } else {
      await _addUserData(
        FirestoreUserPrivateData(sentFriendRequests: [receiverId]),
        senderId,
      );
    }
  }

  Future<void> _deleteSentRequest(
    String senderId,
    String receiverId,
  ) async {
    final senderDoc = await _collectionReference.doc(senderId).get();
    if (senderDoc.exists) {
      await _collectionReference.doc(senderId).update({
        'sentFriendRequests': FieldValue.arrayRemove([receiverId])
      });
    }
  }

  Future<void> _addReceivedFriendRequest(
      String senderId, String receiverId) async {
    final receiverDoc = await _collectionReference.doc(receiverId).get();
    if (receiverDoc.exists) {
      await _collectionReference.doc(receiverId).update({
        'receivedFriendRequests': FieldValue.arrayUnion([senderId])
      });
    } else {
      await _addUserData(
        FirestoreUserPrivateData(receivedFriendRequests: [senderId]),
        receiverId,
      );
    }
  }

  // TODO: to be moved into cloud functions
  Future<void> _deleteReceivedFriendRequest(
      String senderId, String receiverId) async {
    final senderDoc = await _collectionReference.doc(senderId).get();
    if (senderDoc.exists) {
      await _collectionReference.doc(senderId).update({
        'receivedFriendRequests': FieldValue.arrayRemove([senderId])
      });
    }
  }

  Future<FirestoreUserPrivateData?> getUserDataById(String uid) async {
    final docSnapshot = await _collectionReference.doc(uid).get();
    try {
      if (docSnapshot.exists && docSnapshot.data() != null) {
        return FirestoreUserPrivateData.fromJson(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      print("getUserDataById $e");
    }
    return null;
  }

  Future<void> _addUserData(
      FirestoreUserPrivateData userData, String uid) async {
    await _collectionReference.doc(uid).set(userData.toJson());
  }
}
