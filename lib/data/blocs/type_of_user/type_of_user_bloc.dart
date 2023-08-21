// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'type_of_user_event.dart';
part 'type_of_user_state.dart';

class TypeOfUserBloc extends Bloc<TypeOfUserEvent, TypeOfUserState> {
  TypeOfUserBloc() : super(TypeOfUserInitial()) {
    on<UserChooseTypeEvent>((event, emit) {
      if (event.isOwner) {
        emit(ChossingOwner(isOwner: true));
      } else {
        emit(ChossingCustomer(isOwner: false));
      }
    });
  }
}



// void _navigateToCustomerPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) =>
//             OwnerHome()), // Replace with your actual owner page widget
//   );
// }
