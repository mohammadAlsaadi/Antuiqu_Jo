part of 'owner_home_bloc.dart';

sealed class OwnerHomeState {}

final class LoadingCarState extends OwnerHomeState {}

final class LoadedCarState extends OwnerHomeState {
  final List<CarInfo> carData;

  LoadedCarState(this.carData);
}

class DeleteCarSuccessfullyState extends OwnerHomeState {}

class CarFailureState extends OwnerHomeState {}
