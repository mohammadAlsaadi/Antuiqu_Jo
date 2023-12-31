part of 'customer_home_bloc.dart';

sealed class CustomerHomeState {}

final class CustomerHomeInitial extends CustomerHomeState {}

class LoadingCarsState extends CustomerHomeState {}

class LoadedCarsState extends CustomerHomeState {
  final List<CarInfo> carData;

  LoadedCarsState(this.carData);
}

class FailureLoadedCarsState extends CustomerHomeState {}

class BookCarSuccessedState extends CustomerHomeState {}

class BookCarFailedState extends CustomerHomeState {}
