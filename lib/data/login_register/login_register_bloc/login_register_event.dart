part of 'login_register_bloc.dart';

@immutable
sealed class LoginRegisterEvent {}

class ToggleVisibilityEvent extends LoginRegisterEvent {
  final bool isObsecure;

  ToggleVisibilityEvent(this.isObsecure);
}

class OwnerSignUpEvent extends LoginRegisterEvent {
  final OwnerInfo ownerModel;
  final String email;
  final String password;

  OwnerSignUpEvent(
      {required this.email, required this.password, required this.ownerModel});
}

class CustomerSignUpEvent extends LoginRegisterEvent {
  final CustomersInfo customerModel;
  final String email;
  final String password;

  CustomerSignUpEvent(
      {required this.email,
      required this.password,
      required this.customerModel});
}

class LogoutEvent extends LoginRegisterEvent {}

class LoginSuccessEvent extends LoginRegisterEvent {
  final String email;
  final String password;

  LoginSuccessEvent({required this.email, required this.password});
}
