part of 'login_register_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

@immutable
sealed class LoginRegisterState {}

// class AuthState extends LoginRegisterState {
//   final AuthStatus status;

//   AuthState(this.status);

//   @override
//   List<Object?> get props => [status];
// }

final class LoginRegisterInitial extends LoginRegisterState {}

final class LoginRegisterLoading extends LoginRegisterState {}

final class LoginRegisterLoaded extends LoginRegisterState {}

final class LoginRegisterFailure extends LoginRegisterState {}

class VisibilityToggledState extends LoginRegisterState {
  final bool isObsecure;

  VisibilityToggledState(this.isObsecure);
}
