import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_register_event.dart';
part 'login_register_state.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  LoginRegisterBloc() : super(LoginRegisterInitial()) {
    on<ToggleVisibilityEvent>((event, emit) {
      emit(VisibilityToggledState(!event.isObsecure));
    });
  }
}
