import 'dart:convert';

import 'package:antique_jo/models/owner/owners_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerDataSignUp {
  static Future<void> saveSignUpData(OwnersInfo newUserSignup) async {
    List users = await loadUsers();
    users.add(newUserSignup);

    final signUpData = users.map((user) => user.toJson()).toList();
    final signUpJson = json.encode(signUpData);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('users', signUpJson);
  }

  static Future<List<dynamic>> loadUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUsers = prefs.getString('users') ?? '[]';
    List<dynamic> userData = jsonDecode(jsonUsers);
    List users = userData.map((user) => OwnersInfo.fromJson(user)).toList();
    return users;
  }
}
