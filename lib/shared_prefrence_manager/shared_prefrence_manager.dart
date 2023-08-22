import 'dart:convert';

import 'package:antique_jo/models/owner/owner_Info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceManager {
  static Future<void> saveData(String key, OwnerInfo newUserSignup) async {
    List users = await loadData(key: key);
    users.add(newUserSignup);

    final signUpData = users.map((user) => user.toJosn()).toList();
    final signUpJson = json.encode(signUpData);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, signUpJson);
  }

  static Future<List<dynamic>> loadData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUsers = prefs.getString(key) ?? '[]';
    List<dynamic> userData = jsonDecode(jsonUsers);
    List users = userData.map((user) => OwnerInfo.fromJson(user)).toList();
    return users;
  }
}
