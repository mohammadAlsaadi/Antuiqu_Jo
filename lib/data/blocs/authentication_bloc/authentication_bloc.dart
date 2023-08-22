// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:antique_jo/data/repository/auth/auth_repository.dart';
import 'package:antique_jo/data/repository/owner_repository/owner_repository.dart';
import 'package:antique_jo/models/owner/owners_info.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthState> {
  final AuthRepository _authRepository;
  final OwnerRepository _ownerRepository;
  StreamSubscription<User?>? _authOwnerSubscription;
  StreamSubscription<OwnersInfo?>? _ownerStreamSubscription;
  AuthenticationBloc(
      {required AuthRepository authRepository,
      required OwnerRepository ownerRepository})
      : _authRepository = authRepository,
        _ownerRepository = ownerRepository,
        super(const AuthState.unknown()) {
    on<AuthOwnerChangeEvent>(_onAuthOwnerChangeEvent);
    _authOwnerSubscription = _authRepository.user.listen((authOwner) {
      if (authOwner != null) {
        _ownerRepository.getUser(authOwner.uid).listen((owner) {
          add(AuthOwnerChangeEvent(authOwner: authOwner, owner: owner));
        });
      } else {
        add(AuthOwnerChangeEvent(authOwner: authOwner));
      }
    });
  }

  void _onAuthOwnerChangeEvent(
      AuthOwnerChangeEvent event, Emitter<AuthState> emit) {
    event.authOwner != null
        ? emit(AuthState.authentication(
            authOwner: event.authOwner!, owner: event.owner!))
        : emit(const AuthState.unauthentication());
  }

  @override
  Future<void> close() {
    _authOwnerSubscription?.cancel();
    _ownerStreamSubscription?.cancel();
    return super.close();
  }
}
