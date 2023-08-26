import 'dart:convert';

import 'package:antique_jo/models/owner/owner_Info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';

class LoginRegistrationOwnerRepository {
  static Future<void> saveOwnerData({required OwnerInfo newOwnerModel}) async {
    final newOwnerJsonModel = json.encode(newOwnerModel.toString());

    String ownerUID = newOwnerModel.ownerUUID;

    const String userType = 'owner';
    await SharedPreferenceManager.saveString(
        key: ownerUID, value: newOwnerJsonModel);
    await SharedPreferenceManager.saveString(
        key: 'currentUID', value: ownerUID);
    await SharedPreferenceManager.saveString(
        key: 'currentType', value: userType);
    print('ownerUID: $ownerUID');
  }

  static Future<String?> getOwnerData({required String key}) async {
    String? ownerModel = await SharedPreferenceManager.getString(key: key);

    return ownerModel;
  }

  static void removeData(String key) {
    SharedPreferenceManager.removeData(key);
  }
}
