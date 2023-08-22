import 'package:antique_jo/data/repository/current_user_uid/current_user_uid.dart';
import 'package:antique_jo/screen/owner_home/owner_home_functions.dart';
import 'package:antique_jo/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              const Text("Owner HomE Page"),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  OwnerHomeFunctions.handleLogout(context);

                  CurrentUser.logout();
                },
                icon: const Icon(Icons.logout_outlined, color: buttonWhite),
              )
            ],
          ),
        ),
        backgroundColor: appBarColor,
      ),
    );
  }
}
