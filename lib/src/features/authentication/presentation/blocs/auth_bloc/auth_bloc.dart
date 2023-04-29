import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/src/features/authentication/data/auth_repository.dart';
import 'package:trivia_app/src/features/authentication/domain/models/auth_user_data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          AuthRepository().currentUserData.isNotEmpty
              ? AuthState.authenticated(AuthRepository().currentUserData)
              : const AuthState.unauthenticated(),
        ) {
    on<AuthDataChanged>(_onAuthDataChangedChanged);
    on<UserLoggedIn>(_onUserLoggedIn);
  }

  void _onAuthDataChangedChanged(AuthDataChanged event, Emitter<AuthState> emit) {
    print('User changed');

    if (event.userData.isNotEmpty) {
      add(UserLoggedIn(event.userData));
    }

    emit(
      event.userData.isNotEmpty ? AuthState.authenticated(event.userData) : const AuthState.unauthenticated(),
    );
  }

  Future<void> _onUserLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authUserData: event.userData));
  }
}
