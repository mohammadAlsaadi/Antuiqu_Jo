part of 'login_register_bloc.dart';

@immutable
sealed class LoginRegisterState {}

final class LoginRegisterInitial extends LoginRegisterState {}

class VisibilityToggledState extends LoginRegisterState {
  final bool isObsecure;

  VisibilityToggledState(this.isObsecure);
}
