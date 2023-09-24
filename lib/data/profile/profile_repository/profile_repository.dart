// ignore_for_file: avoid_print

import 'package:antique_jo/data/login_register/login_register_models/customer/customers_info.dart';
import 'package:antique_jo/data/login_register/login_register_models/owner/owner_Info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  static Future<CustomersInfo> customerInformation() async {
    String currentUserKey =
        await SharedPreferenceManager.getString(key: 'currentUID');
    FirebaseFirestore data = FirebaseFirestore.instance;

    DocumentSnapshot<Map<String, dynamic>> customerMap =
        await data.collection('customer').doc(currentUserKey).get();
    CustomersInfo customerInformation = CustomersInfo(
        customerEmail: customerMap['Email'],
        customerPassword: '',
        customerUUID: customerMap['customerUID'],
        customerFullName: customerMap['Name'],
        customerPhoneNumber: customerMap['Phone number'],
        customerAge: customerMap['Age'],
        customerGender: customerMap['Gender']);
    return customerInformation;
  }

  static Future<OwnerInfo> ownerInformation() async {
    String currentUserKey =
        await SharedPreferenceManager.getString(key: 'currentUID');
    FirebaseFirestore data = FirebaseFirestore.instance;

    DocumentSnapshot<Map<String, dynamic>> ownerMap =
        await data.collection('owners').doc(currentUserKey).get();
    OwnerInfo ownerInformation = OwnerInfo(
        ownerEmail: ownerMap['email'],
        ownerPassword: '',
        ownerUUID: ownerMap['ownerUID'],
        ownerFullName: ownerMap['name'],
        ownerPhoneNumber: ownerMap['ownerPhoneNumber'],
        ownerShopName: ownerMap['ownerShopName']);
    return ownerInformation;
  }

  static Future<bool> updateNameOfUser(String newName, bool isOwner) async {
    String ownerUIID =
        await SharedPreferenceManager.getString(key: 'currentUID');

    if (isOwner) {
      try {
        await FirebaseFirestore.instance
            .collection('owners')
            .doc(ownerUIID)
            .update({'name': newName});
        print('Document updated successfully');
        return true;
      } catch (error) {
        print('Error updating document: $error');
        return false;
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('customer')
            .doc(ownerUIID)
            .update({'Name': newName});
        print('Document updated successfully');
        return true;
      } catch (error) {
        print('Error updating document: $error');
        return false;
      }
    }
  }
}
