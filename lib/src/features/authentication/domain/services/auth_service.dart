import 'package:trivia_app/src/features/authentication/data/auth_repository.dart';
import 'package:trivia_app/src/features/authentication/domain/models/auth_user_data.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_public_repository.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';

class AuthService {
  factory AuthService() => _singleton;

  AuthService._internal() : super();

  static final AuthService _singleton = AuthService._internal();

  final AuthRepository _authRepository = AuthRepository();
  final FirestoreUserPublicRepository _userPublicRepository = FirestoreUserPublicRepository();

  Future<AuthUserData?> registerWithEmailAndPassword({required String emailAddress, required String password, required String displayName}) async {
    try {
      final userData = await _authRepository.registerWithEmailAndPassword(emailAddress: emailAddress, password: password);
      if(userData != null) {
        await _userPublicRepository.addData(FirestoreUserPublicData(id: userData.id, displayName: displayName));
      return userData;
      }
    } catch(_) {
      rethrow;
    }
    return null;
  }
}
