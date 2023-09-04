// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:antique_jo/data/login_register/login_register_models/owner/owner_Info.dart';
import 'package:antique_jo/data/login_register/login_register_models/customer/customers_info.dart';
import 'package:antique_jo/data/login_register/login_register_repository/customer_register_repository/customer_repository.dart';
import 'package:antique_jo/data/login_register/login_register_repository/login_repository/login_repository.dart';
import 'package:antique_jo/data/login_register/login_register_repository/owner_repository/owner_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'login_register_event.dart';
part 'login_register_state.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  LoginRegisterBloc() : super(LoginRegisterInitial()) {
    on<ToggleVisibilityEvent>((event, emit) {
      emit(VisibilityToggledState(!event.isObsecure));
    });
    on<OwnerSignUpEvent>(
      _handleOwnerSignUpEvent,
    );
    on<CustomerSignUpEvent>(
      _handleCustomerSignUpEvent,
    );
    on<LogoutEvent>(
      _handleLogOutEvent,
    );
    on<LoginSuccessEvent>(_handleLoginEvent);
  }
}

Future<void> _handleOwnerSignUpEvent(
    OwnerSignUpEvent event, Emitter<LoginRegisterState> emit) async {
  emit(LoginRegisterLoading());

  LoginRegistrationOwnerRepository.isTheDataUploadedToFirestor(
      ownerModel: event.ownerModel);
  bool isUploaded =
      await LoginRegistrationOwnerRepository.isTheDataUploadedToFirestor(
          ownerModel: event.ownerModel);

  if (isUploaded) {
    emit(LoginRegisterLoaded());
  } else {
    emit(LoginRegisterFailure());
  }
}

Future<void> _handleCustomerSignUpEvent(
    CustomerSignUpEvent event, Emitter<LoginRegisterState> emit) async {
  emit(LoginRegisterLoading());

  await LoginRegistrationCustomerRepository.isTheDataUploadedToFirestor(
      customerModel: event.customerModel);
  bool isUploaded =
      await LoginRegistrationCustomerRepository.isTheDataUploadedToFirestor(
          customerModel: event.customerModel);

  if (isUploaded) {
    emit(LoginRegisterLoaded());
  } else {
    emit(LoginRegisterFailure());
  }
}

Future<void> _handleLogOutEvent(
    LogoutEvent event, Emitter<LoginRegisterState> emit) async {
  try {
    LoginRegistrationOwnerRepository.removeData('currentUID');
    emit(LogoutState());
  } catch (_) {}
}

Future<void> _handleLoginEvent(
    LoginSuccessEvent event, Emitter<LoginRegisterState> emit) async {
  LoginRepository.isLoginSuccessful(
      email: event.email, password: event.password);
  bool isSuccessfil = await LoginRepository.isLoginSuccessful(
      email: event.email, password: event.password);

  if (isSuccessfil) {
    emit(LoginRegisterLoaded());
  } else {
    emit(LoginRegisterFailure());
  }
}
