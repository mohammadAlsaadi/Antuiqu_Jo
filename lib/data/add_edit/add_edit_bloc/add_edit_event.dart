// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_bloc.dart';

@immutable
sealed class AddEditEvent {}

class SelectTypeOfCarEvent extends AddEditEvent {
  final int selectedIndex;

  SelectTypeOfCarEvent({required this.selectedIndex});
}

class SelectColorOfCarEvent extends AddEditEvent {
  final int selectedIndex;

  SelectColorOfCarEvent({required this.selectedIndex});
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
  String tyoeOfCar;
  String colorOfCar;
  FitchCarImageEvent({
    required this.tyoeOfCar,
    required this.colorOfCar,
  });
}
