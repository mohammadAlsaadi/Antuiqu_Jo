import 'package:antique_jo/screen/auth_screen/login.dart/login_page.dart';
import 'package:flutter/material.dart';

class OwnerHomeFunctions {
  static void handleLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          isOwner: null,
        ),
      ),
      (route) => false,
    );
  }
}
