// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_bloc.dart';

@immutable
sealed class AddEditEvent {}

class SelectTypeOfCarEvent extends AddEditEvent {
  final int selectedIndexType;

  SelectTypeOfCarEvent({required this.selectedIndexType});
}

class SelectColorOfCarEvent extends AddEditEvent {
  final int selectedIndexColor;

  SelectColorOfCarEvent({required this.selectedIndexColor});
}

class SelectImageOfCarEvent extends AddEditEvent {
  final String carImage;

  SelectImageOfCarEvent({required this.carImage});
}

class AddNewCarEvent extends AddEditEvent {
  final CarInfo carModel;

  AddNewCarEvent({required this.carModel});
}

class EditCarEvent extends AddEditEvent {
  final CarInfo carModel;

  EditCarEvent({required this.carModel});
}

class FitchCarImageEvent extends AddEditEvent {
  final String tyoeOfCar;
  final String colorOfCar;
  FitchCarImageEvent({
    required this.tyoeOfCar,
    required this.colorOfCar,
  });
}
