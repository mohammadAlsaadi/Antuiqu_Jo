// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_home_bloc.dart';

sealed class CustomerHomeEvent {}

class LoadingCarEvent extends CustomerHomeEvent {}

class AllCarFitchEvent extends CustomerHomeEvent {}

class BookCarEvent extends CustomerHomeEvent {
  final CarInfo carModel;

  BookCarEvent({required this.carModel});
}

class MyCarFitchEvent extends CustomerHomeEvent {}
