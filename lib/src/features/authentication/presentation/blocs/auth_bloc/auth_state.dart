part of 'auth_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.authUserData = AuthUserData.empty,
    this.publicUserData = FirestoreUserPublicData.empty,
  });

  const AuthState.authenticated(AuthUserData user)
      : this._(status: AppStatus.authenticated, authUserData: user);

  const AuthState.unauthenticated()
      : this._(
            status: AppStatus.unauthenticated,
            authUserData: AuthUserData.empty,
            publicUserData: FirestoreUserPublicData.empty);

  final AppStatus status;
  final AuthUserData authUserData;
  final FirestoreUserPublicData publicUserData;
  bool get isAuthenticated => authUserData != AuthUserData.empty;

  AuthState copyWith({
    AppStatus? status,
    AuthUserData? authUserData,
    FirestoreUserPublicData? publicUserData,
  }) {
    return AuthState._(
        status: status ?? this.status,
        authUserData: authUserData ?? this.authUserData,
        publicUserData: publicUserData ?? this.publicUserData);
  }

  @override
  List<Object> get props => <Object>[status, authUserData, publicUserData];
}
