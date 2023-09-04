import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/data/owner_home/owner_home_repoitory/owner_home_repository.dart';

part 'owner_home_event.dart';
part 'owner_home_state.dart';

class OwnerHomeBloc extends Bloc<OwnerHomeEvent, OwnerHomeState> {
  OwnerHomeBloc() : super(LoadingCarState()) {
    on<InitialHomeEvent>(_handelLoadCar);

    on<DeleteCarEvent>(_handelDeleteCar);
  }
}

Future<void> _handelLoadCar(
    InitialHomeEvent event, Emitter<OwnerHomeState> emit) async {
  emit(LoadingCarState());
  List<CarInfo> carsLoad = await OwnerHomeRepository.loadCarsFromFirestore();
  await OwnerHomeRepository.loadCarsFromFirestore();

  if (carsLoad.isNotEmpty) {
    emit(LoadedCarState(carsLoad));
  } else {
    emit(CarFailureState());
  }
}

Future<void> _handelDeleteCar(
    DeleteCarEvent event, Emitter<OwnerHomeState> emit) async {
  emit(LoadingCarState());

  await OwnerHomeRepository.deleteCarByDocumentUID(event.carUID);
  bool isDeleteSuccess =
      await OwnerHomeRepository.deleteCarByDocumentUID(event.carUID);
  // await HomeRepository.loadCarsFromFirestore();

  if (isDeleteSuccess) {
    emit(DeleteCarSuccessfullyState());
  } else {
    emit(CarFailureState());
  }
}
