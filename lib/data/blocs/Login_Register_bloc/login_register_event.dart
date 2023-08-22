part of 'login_register_bloc.dart';

@immutable
sealed class LoginRegisterEvent {}

class ToggleVisibilityEvent extends LoginRegisterEvent {
  final bool isObsecure;

  ToggleVisibilityEvent(this.isObsecure);
}

class SignUpEvent extends LoginRegisterEvent {
  final OwnerInfo newUserSignup;

  SignUpEvent({required this.newUserSignup});
}
