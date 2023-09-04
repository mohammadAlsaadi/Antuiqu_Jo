part of 'type_of_user_bloc.dart';

@immutable
sealed class TypeOfUserEvent {}

class UserChooseTypeEvent extends TypeOfUserEvent {
  final bool isOwner;

  UserChooseTypeEvent(this.isOwner);
}
