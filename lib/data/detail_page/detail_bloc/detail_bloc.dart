import 'package:antique_jo/data/detail_page/detail_repository/detail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<SendDataToDetailPageEvent>(_handelSendData);
  }
}

Future<void> _handelSendData(
    SendDataToDetailPageEvent event, Emitter<DetailState> emit) async {
  emit(LoadingState());

  await DetailRepository.getCarDataByIndex(event.index);
  Map<String, dynamic> carsLoad =
      await DetailRepository.getCarDataByIndex(event.index);
  if (carsLoad.isNotEmpty) {
    emit(SendDataSuccessfullyState(carData: carsLoad));
  } else {
    emit(SendDataFailureState());
  }
}
