part of 'type_of_user_bloc.dart';

@immutable
sealed class TypeOfUserState {}

final class TypeOfUserInitial extends TypeOfUserState {}

class ChossingOwner extends TypeOfUserState {
  final bool isOwner;

  ChossingOwner({required this.isOwner});
}

class ChossingCustomer extends TypeOfUserState {
  final bool isOwner;

  ChossingCustomer({required this.isOwner});
}
