import 'package:antique_jo/data/blocs/Login_Register_bloc/login_register_bloc.dart';
import 'package:antique_jo/screen/type_of_user/type_of_user_screen.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:antique_jo/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginRegisterBloc(),
      child: Scaffold(
        backgroundColor: backgroundColor,
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
                      width: 70,
                    ),
                    const Text("Owner Home Page"),
                    const SizedBox(
                      width: 70,
                    ),
                  ],
                ),
              );
            },
          ),
          backgroundColor: appBarColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '',
                style: appBarFont,
              )
            ],
          ),
        ),
      ),
    );
  }
}
