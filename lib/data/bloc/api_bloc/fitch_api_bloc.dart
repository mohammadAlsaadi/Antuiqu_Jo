import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fitch_api_event.dart';
part 'fitch_api_state.dart';

class FitchApiBloc extends Bloc<FitchApiEvent, FitchApiState> {
  FitchApiBloc() : super(FitchApiInitial()) {
    on<FitchApiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
