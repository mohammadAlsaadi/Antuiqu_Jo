// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class LoadingProfileDataState extends ProfileState {}

class LoadedOwnerProfileDataState extends ProfileState {
  final OwnerInfo ownerInfo;
  LoadedOwnerProfileDataState({
    required this.ownerInfo,
  });
}

class LoadedCustomerProfileDataState extends ProfileState {
  final CustomersInfo customersInfo;
  LoadedCustomerProfileDataState({
    required this.customersInfo,
  });
}

class ChangeNameState extends ProfileState {
  final String nameOfUser;

  ChangeNameState({required this.nameOfUser});
}

class FailedLoadingProfileData extends ProfileState {}
