// ignore_for_file: avoid_print

import 'package:antique_jo/data/login_register/login_register_repository/auth/firebase_auth.dart';
import 'package:antique_jo/data/login_register/login_register_models/customer/customers_info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRegistrationCustomerRepository {
  static Future<void> saveCustomerData({required String userUID}) async {
    const String userType = 'customer';

    await SharedPreferenceManager.saveString(key: 'currentUID', value: userUID);
    await SharedPreferenceManager.saveString(
        key: 'currentType', value: userType);
  }

  static Future<String?> getCustomerUID({required String key}) async {
    String? userUID = await SharedPreferenceManager.getString(key: key);

    return userUID;
  }

  static void removeData(String key) {
    SharedPreferenceManager.removeData(key);
  }

  static Future<bool> isTheDataUploadedToFirestor(
      {required CustomersInfo customerModel}) async {
    String email = customerModel.customerEmail;
    String password = customerModel.customerPassword;
    String name = customerModel.customerFullName;
    String age = customerModel.customerAge;
    String phoneNumber = customerModel.customerPhoneNumber;
    String gender = customerModel.customerGender;

    try {
      await Auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userUID =
          await Auth.fitchUserUIDFromFirebase(email: email, password: password);

      CollectionReference customer =
          FirebaseFirestore.instance.collection('customer');

      Map<String, dynamic> customerDataForFirestore = {
        'Email': email,
        'Name': name,
        'Age': age,
        'Gender': gender,
        'Phone number': phoneNumber,
        'customerUID': userUID,
      };
      await LoginRegistrationCustomerRepository.saveCustomerData(
          userUID: userUID);
      customer.doc(userUID).set(customerDataForFirestore);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
