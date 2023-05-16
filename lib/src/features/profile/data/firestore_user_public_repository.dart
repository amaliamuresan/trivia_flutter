import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';

class FirestoreUserPublicRepository {
  factory FirestoreUserPublicRepository() => _singleton;

  FirestoreUserPublicRepository._internal() : super();

  static final FirestoreUserPublicRepository _singleton = FirestoreUserPublicRepository._internal();

  final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection('userPublicData');

  Future<void> addData(FirestoreUserPublicData userData) async {
    try {
      await _collectionReference.doc(userData.id).set(userData.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('AuthService $e');
      }
    }
  }

  void listenUserDataChange(String uid, void Function(FirestoreUserPublicData) onDataChanged) {
    _collectionReference.doc(uid).snapshots().listen(
      (docSnapshot) {
        if (docSnapshot.exists && docSnapshot.data() != null) {
          onDataChanged(FirestoreUserPublicData.fromJson(docSnapshot.data()!, uid));
        }
      },
    );
  }
}
