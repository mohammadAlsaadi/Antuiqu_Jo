// ignore_for_file: avoid_print

import 'package:antique_jo/data/login_register/login_register_models/customer/customers_info.dart';
import 'package:antique_jo/data/login_register/login_register_models/owner/owner_Info.dart';
import 'package:antique_jo/data/profile/profile_repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(LoadingProfileDataState()) {
    on<LoadCustomerProfileEvent>(_handelLoadedCustomerProfileDats);
    on<LoadOwnerProfileEvent>(_handelLoadedOwnerProfileDats);
    on<ChangeNameEvent>(_handelChangeOfName);
  }
}

Future<void> _handelLoadedCustomerProfileDats(
    LoadCustomerProfileEvent event, Emitter<ProfileState> emit) async {
  emit(LoadingProfileDataState());
  try {
    CustomersInfo customerInfo = await ProfileRepository.customerInformation();
    emit(LoadedCustomerProfileDataState(customersInfo: customerInfo));
  } catch (e) {
    emit(FailedLoadingProfileData());
    print(e);
  }
}

Future<void> _handelLoadedOwnerProfileDats(
    LoadOwnerProfileEvent event, Emitter<ProfileState> emit) async {
  emit(LoadingProfileDataState());
  try {
    OwnerInfo ownerInfo = await ProfileRepository.ownerInformation();
    emit(LoadedOwnerProfileDataState(ownerInfo: ownerInfo));
  } catch (e) {
    emit(FailedLoadingProfileData());
    print(e);
  }
}

Future<void> _handelChangeOfName(
    ChangeNameEvent event, Emitter<ProfileState> emit) async {
  emit(LoadingProfileDataState());
  try {
    if (event.isOwner) {
      await ProfileRepository.updateNameOfUser(event.nameOfUser, true);
      emit(ChangeNameState(nameOfUser: event.nameOfUser));
    } else {
      await ProfileRepository.updateNameOfUser(event.nameOfUser, false);
      emit(ChangeNameState(nameOfUser: event.nameOfUser));
    }
  } catch (e) {
    emit(FailedLoadingProfileData());
    print(e);
  }
}
