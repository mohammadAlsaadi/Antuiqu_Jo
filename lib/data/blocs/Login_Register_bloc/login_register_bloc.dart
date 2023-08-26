// ignore_for_file: depend_on_referenced_packages

import 'package:antique_jo/data/repository/auth/firebase_auth.dart';
import 'package:antique_jo/data/repository/customer_repository/customer_repository.dart';
import 'package:antique_jo/data/repository/owner_repository/owner_repository.dart';
import 'package:antique_jo/models/customer/customers_info.dart';
import 'package:antique_jo/models/owner/owner_Info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
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

  try {
    await LoginRegistrationOwnerRepository.saveOwnerData(
        newOwnerModel: event.newOwnerModel);
    Auth.createUserWithEmailAndPassword(
        email: event.email, password: event.password);
    emit(LoginRegisterLoaded());
  } catch (e) {
    emit(LoginRegisterFailure());
  }
}

Future<void> _handleCustomerSignUpEvent(
    CustomerSignUpEvent event, Emitter<LoginRegisterState> emit) async {
  emit(LoginRegisterLoading());

  try {
    await LoginRegistrationCustomerRepository.saveCustomerData(
        newUserModel: event.newCustomerModel);
    Auth.createUserWithEmailAndPassword(
        email: event.email, password: event.password);

    emit(LoginRegisterLoaded());
  } catch (e) {
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
  try {
    String userUID = Auth.fitchUserUIDFromFirebase(
            email: event.email, password: event.password)
        .toString();

    await SharedPreferenceManager.saveString(
      key: 'currentUID',
      value: userUID,
    );
    Auth.signInWithEmailAndPassword(
        email: event.email, password: event.password);
    emit(LoginRegisterLoaded());
  } catch (e) {
    print("Login Error from bloc: $e");
  }
}
