part of 'login_register_bloc.dart';

@immutable
sealed class LoginRegisterEvent {}

class ToggleVisibilityEvent extends LoginRegisterEvent {
  final bool isObsecure;

  ToggleVisibilityEvent(this.isObsecure);
}

class OwnerSignUpEvent extends LoginRegisterEvent {
  final OwnerInfo newOwnerModel;
  final String email;
  final String password;

  OwnerSignUpEvent(
      {required this.email,
      required this.password,
      required this.newOwnerModel});
}

class CustomerSignUpEvent extends LoginRegisterEvent {
  final CustomersInfo newCustomerModel;
  final String email;
  final String password;

  CustomerSignUpEvent(
      {required this.email,
      required this.password,
      required this.newCustomerModel});
}

class LogoutEvent extends LoginRegisterEvent {}

class LoginSuccessEvent extends LoginRegisterEvent {
  final String email;
  final String password;

  LoginSuccessEvent({required this.email, required this.password});
}
