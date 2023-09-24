// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class LoadOwnerProfileEvent extends ProfileEvent {
  final bool isOwner;
  LoadOwnerProfileEvent({
    required this.isOwner,
  });
}

class LoadCustomerProfileEvent extends ProfileEvent {
  final bool isOwner;

  LoadCustomerProfileEvent({
    required this.isOwner,
  });
}

class ChangeNameEvent extends ProfileEvent {
  final bool isOwner;
  final String nameOfUser;
  ChangeNameEvent({
    required this.isOwner,
    required this.nameOfUser,
  });
}
