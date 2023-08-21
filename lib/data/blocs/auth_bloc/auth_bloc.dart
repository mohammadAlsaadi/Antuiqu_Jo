// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:antique_jo/data/repo/auth/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc({required this.authRepo}) : super(UnAuth()) {
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        authRepo.signUp(email: event.email, password: event.password);
      } catch (e) {
        emit(UnAuth());
      }
    });
  }
}
