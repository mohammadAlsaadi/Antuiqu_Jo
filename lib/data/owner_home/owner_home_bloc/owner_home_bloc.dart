import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/data/owner_home/owner_home_repoitory/owner_home_repository.dart';

part 'owner_home_event.dart';
part 'owner_home_state.dart';

class OwnerHomeBloc extends Bloc<OwnerHomeEvent, OwnerHomeState> {
  OwnerHomeBloc() : super(LoadingCarState()) {
    on<DeleteCarEvent>(_handelDeleteCar);
    on<InitialHomeEvent>(_handelLoadCar);
  }
}

Future<void> _handelLoadCar(
    InitialHomeEvent event, Emitter<OwnerHomeState> emit) async {
  List<CarInfo> carsLoad = await OwnerHomeRepository.loadCarsFromFirestore();

  emit(LoadingCarState());

  if (carsLoad.isNotEmpty) {
    emit(LoadedCarState(carsLoad));
  } else {
    emit(CarFailureState());
  }
}

Future<void> _handelDeleteCar(
    DeleteCarEvent event, Emitter<OwnerHomeState> emit) async {
  emit(LoadingCarState());

  bool isDeleteSuccess =
      await OwnerHomeRepository.deleteCarByDocumentUID(event.carUID);
  // await HomeRepository.loadCarsFromFirestore();

  if (isDeleteSuccess) {
    emit(DeleteCarSuccessfullyState());
  } else {
    emit(CarFailureState());
  }
}
