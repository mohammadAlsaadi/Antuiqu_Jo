// ignore_for_file: avoid_print

import 'package:antique_jo/data/login_register/login_register_models/owner/owner_Info.dart';
import 'package:antique_jo/data/login_register/login_register_repository/auth/firebase_auth.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRegistrationOwnerRepository {
  static Future<void> saveOwnerData({required String userUID}) async {
    const String userType = 'owner';

    await SharedPreferenceManager.saveString(key: 'currentUID', value: userUID);
    await SharedPreferenceManager.saveString(
        key: 'currentType', value: userType);
  }

  static Future<String?> getOwnerUID({required String key}) async {
    String? userUID = await SharedPreferenceManager.getString(key: key);

    return userUID;
  }

  static void removeData(String key) {
    SharedPreferenceManager.removeData(key);
  }

  static Future<bool> isTheDataUploadedToFirestor(
      {required OwnerInfo ownerModel}) async {
    String email = ownerModel.ownerEmail;
    String password = ownerModel.ownerPassword;
    String name = ownerModel.ownerFullName;
    String shopName = ownerModel.ownerShopName;
    String phoneNumber = ownerModel.ownerPhoneNumber;

    try {
      await Auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userUID =
          await Auth.fitchUserUIDFromFirebase(email: email, password: password);

      CollectionReference owner =
          FirebaseFirestore.instance.collection('owners');

      Map<String, dynamic> ownerData = {
        'email': email,
        'name': name,
        'ownerShopName': shopName,
        'ownerPhoneNumber': phoneNumber,
        'ownerUID': userUID,
      };
      await LoginRegistrationOwnerRepository.saveOwnerData(userUID: userUID);
      await owner.doc(userUID).set(ownerData);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
