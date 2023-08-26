// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:antique_jo/screen/cusromer_home/customer_home_screen.dart';
import 'package:antique_jo/screen/owner_home/owner_home_screen.dart';
import 'package:antique_jo/screen/type_of_user/type_of_user_screen.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Fixed constructor

  Future<String?> getCurrentUID() async {
    Future<String?> currentUID =
        SharedPreferenceManager.getString(key: 'currentUID');

    return currentUID;
  }

  Future<String?> getCurrentType() async {
    Future<String?> currentType =
        SharedPreferenceManager.getString(key: 'currentType');

    return currentType;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: getCurrentUID(),
        builder: (context, uidSnapshot) {
          if (uidSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          String? currentUID = uidSnapshot.data;

          if (currentUID != null && currentUID.isNotEmpty) {
            return FutureBuilder<String?>(
              future: getCurrentType(),
              builder: (context, typeSnapshot) {
                if (typeSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                String? currentType = typeSnapshot.data;

                if (currentType == 'owner') {
                  return const OwnerHomePage();
                } else if (currentType == 'customer') {
                  return const customerHomePage();
                } else {
                  return const TypeOfUser();
                }
              },
            );
          } else {
            return const TypeOfUser();
          }
        },
      ),
    );
  }
}
