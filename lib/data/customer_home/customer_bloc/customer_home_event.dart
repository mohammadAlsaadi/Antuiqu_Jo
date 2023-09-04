part of 'customer_home_bloc.dart';

sealed class CustomerHomeEvent {}

class AllCarFitchEvent extends CustomerHomeEvent {}

class BookCarEvent extends CustomerHomeEvent {
  final CarInfo carModel;

  BookCarEvent({required this.carModel});
}

class MyCarFitchEvent extends CustomerHomeEvent {}
