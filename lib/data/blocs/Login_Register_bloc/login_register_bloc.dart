// ignore_for_file: depend_on_referenced_packages

import 'package:antique_jo/data/repository/current_user_uid/current_user_uid.dart';
import 'package:antique_jo/data/repository/owner_save_date/owner_save_data.dart';
import 'package:antique_jo/models/owner/owner_Info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_register_event.dart';
part 'login_register_state.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  LoginRegisterBloc() : super(LoginRegisterInitial()) {
    on<ToggleVisibilityEvent>((event, emit) {
      emit(VisibilityToggledState(!event.isObsecure));
    });
    on<SignUpEvent>((event, emit) async {
      emit(LoginRegisterLoading());

      try {
        await SharedPrefrenceManager.saveData(
            'newUserSignup', event.newUserSignup);
        CurrentUser.signUpCurrent(event.newUserSignup.ownerUUID);

        emit(LoginRegisterLoaded());
      } catch (e) {
        emit(LoginRegisterFailure());
      }
    });
  }
}
