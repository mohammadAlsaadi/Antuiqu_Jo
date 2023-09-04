part of 'owner_home_bloc.dart';

@immutable
sealed class OwnerHomeEvent {}

class InitialHomeEvent extends OwnerHomeEvent {}

class DeleteCarEvent extends OwnerHomeEvent {
  final String carUID;

  DeleteCarEvent({required this.carUID});
}
