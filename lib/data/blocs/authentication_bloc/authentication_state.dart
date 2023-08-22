part of 'authentication_bloc.dart';

enum AuthStatus { unknown, authentication, unauthentication }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? authOwner;
  final OwnersInfo? owner;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.authOwner,
    this.owner,
  });

  const AuthState.unknown()
      : status = AuthStatus.unknown,
        authOwner = null,
        owner = null;

  const AuthState.authentication(
      {required User this.authOwner, required OwnersInfo this.owner})
      : status = AuthStatus.authentication;

  const AuthState.unauthentication()
      : status = AuthStatus.unauthentication,
        authOwner = null,
        owner = null;

  @override
  List<Object?> get props => [status, authOwner, owner];
}
