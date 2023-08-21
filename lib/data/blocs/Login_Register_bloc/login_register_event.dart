part of 'login_register_bloc.dart';

@immutable
sealed class LoginRegisterEvent {}

class ToggleVisibilityEvent extends LoginRegisterEvent {
  final bool isObsecure;

  ToggleVisibilityEvent(this.isObsecure);
}
