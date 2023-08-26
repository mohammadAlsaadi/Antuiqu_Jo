import 'package:antique_jo/data/blocs/Login_Register_bloc/login_register_bloc.dart';

import 'package:antique_jo/screen/type_of_user/type_of_user_screen.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class customerHomePage extends StatefulWidget {
  const customerHomePage({super.key});

  @override
  State<customerHomePage> createState() => _customerHomePageState();
}

//String currentUID =
// LoginRegistrationCustomerRepository.getCustomerData('currentID').toString();

class _customerHomePageState extends State<customerHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginRegisterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
            listener: (context, state) {
              if (state is LogoutState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TypeOfUser(),
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return Center(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<LoginRegisterBloc>(context)
                            .add(LogoutEvent());
                      },
                      icon:
                          const Icon(Icons.logout_outlined, color: buttonWhite),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text("Customer Home Page"),
                  ],
                ),
              );
            },
          ),
          backgroundColor: appBarColor,
        ),
      ),
    );
  }
}
