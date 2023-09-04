import 'package:antique_jo/data/type_of_user/type_of_user/type_of_user_bloc.dart';
import 'package:antique_jo/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget ownerCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      BlocProvider.of<TypeOfUserBloc>(context).add(UserChooseTypeEvent(true));
    },
    child: Card(
      child: Container(
        width: 340,
        height: 180,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/owner.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          child: Container(
            width: 340,
            height: 180,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  const Color.fromARGB(255, 113, 113, 113).withAlpha(210),
                  const Color.fromARGB(31, 107, 106, 106).withAlpha(210),
                  const Color.fromARGB(179, 108, 107, 107).withAlpha(210),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Owner",
                  style: appBarFont,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget userCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      BlocProvider.of<TypeOfUserBloc>(context).add(UserChooseTypeEvent(false));
    },
    child: Card(
      child: Container(
        width: 340,
        height: 180,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/customer.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          child: Container(
            width: 340,
            height: 180,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  const Color.fromARGB(255, 113, 113, 113).withAlpha(210),
                  const Color.fromARGB(31, 107, 106, 106).withAlpha(210),
                  const Color.fromARGB(179, 108, 107, 107).withAlpha(210),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Customer",
                  style: appBarFont,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
