import 'dart:convert';

import 'package:antique_jo/models/customer/customers_info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';

class LoginRegistrationCustomerRepository {
  static Future<void> saveCustomerData(
      {required CustomersInfo newUserModel}) async {
    final String newCustomerJsonModel = json.encode(newUserModel.toString());
    String customerUID = newUserModel.customerUUID;
    const String userType = 'customer';
    await SharedPreferenceManager.saveString(
        key: customerUID, value: newCustomerJsonModel);
    await SharedPreferenceManager.saveString(
        key: 'currentUID', value: customerUID);
    await SharedPreferenceManager.saveString(
        key: 'currentType', value: userType);
    print('customerUID: $customerUID');
  }

  static Future<String?> getCustomerData({required String key}) async {
    String? customerModel = await SharedPreferenceManager.getString(key: key);
    print(customerModel);
    return customerModel;
  }

  static void removeData(String key) {
    SharedPreferenceManager.removeData(key);
  }
}
