import 'package:antique_jo/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:antique_jo/data/blocs/type_of_user/type_of_user_bloc.dart';
import 'package:antique_jo/data/repo/auth/auth_repo.dart';

import 'package:antique_jo/screen/type_of_user/type_of_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: const TypeOfUser());
  }
}
