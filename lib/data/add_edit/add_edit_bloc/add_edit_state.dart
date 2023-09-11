// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_edit_bloc.dart';

@immutable
sealed class AddEditState {}

final class AddEditInitial extends AddEditState {}

class TypeOfCarState extends AddEditState {
  final int stateOfIndex;

  TypeOfCarState({required this.stateOfIndex});
}

class ColorOfCarState extends AddEditState {
  final int stateOfIndex;

  ColorOfCarState({required this.stateOfIndex});
}

class ImageOfCarState extends AddEditState {
  final String imageCar;

  ImageOfCarState({required this.imageCar});
}

class AddCarSuccessfullyState extends AddEditState {}

class EditCarSuccessfullyState extends AddEditState {}

class CarLoadingState extends AddEditState {}

class CarLoadedState extends AddEditState {
  List<String> carImages;
  CarLoadedState({
    required this.carImages,
  });
}

class CarFailureState extends AddEditState {}
