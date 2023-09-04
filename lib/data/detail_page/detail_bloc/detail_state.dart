part of 'detail_bloc.dart';

sealed class DetailState {}

final class DetailInitial extends DetailState {}

class LoadingState extends DetailState {}

class SendDataSuccessfullyState extends DetailState {
  final Map<String, dynamic> carData;

  SendDataSuccessfullyState({required this.carData});
}

class SendDataFailureState extends DetailState {}
