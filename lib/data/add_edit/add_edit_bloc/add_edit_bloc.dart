import 'package:antique_jo/data/add_edit/add_edit_repository/car_repository/car_repository.dart';
import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'add_edit_event.dart';
part 'add_edit_state.dart';

class AddEditBloc extends Bloc<AddEditEvent, AddEditState> {
  AddEditBloc() : super(AddEditInitial()) {
    on<SelectTypeOfCarEvent>(_selectType);
    on<SelectColorOfCarEvent>(_selectColor);
    on<SelectImageOfCarEvent>(_selectImage);
    on<AddNewCarEvent>(_addCar);
    on<EditCarEvent>(_editCar);
  }
}

Future<void> _selectType(
    SelectTypeOfCarEvent event, Emitter<AddEditState> emit) async {
  emit(TypeOfCarState(stateOfIndex: event.selectedIndex));
}

Future<void> _selectColor(
    SelectColorOfCarEvent event, Emitter<AddEditState> emit) async {
  emit(ColorOfCarState(stateOfIndex: event.selectedIndex));
}

Future<void> _selectImage(
    SelectImageOfCarEvent event, Emitter<AddEditState> emit) async {
  String carSelected = event.carImage;
  emit(ImageOfCarState(imageCar: carSelected));
}

Future<void> _addCar(AddNewCarEvent event, Emitter<AddEditState> emit) async {
  emit(CarLoadingState());
  await CarRepository.isCarDataUploadedToFirestor(car: event.carModel);

  bool isUploaded =
      await CarRepository.isCarDataUploadedToFirestor(car: event.carModel);
  // HomeRepository.loadCarsFromFirestore();

  if (isUploaded) {
    emit((AddCarSuccessfullyState()));
  } else {
    emit(CarFailureState());
  }
}

Future<void> _editCar(EditCarEvent event, Emitter<AddEditState> emit) async {
  emit(CarLoadingState());

  await CarRepository.updateCar(event.carModel.carUUID, event.carModel);

  bool isUploaded =
      await CarRepository.updateCar(event.carModel.carUUID, event.carModel);
  // HomeRepository.loadCarsFromFirestore();

  if (isUploaded) {
    emit((EditCarSuccessfullyState()));
  } else {
    emit(CarFailureState());
  }
}
