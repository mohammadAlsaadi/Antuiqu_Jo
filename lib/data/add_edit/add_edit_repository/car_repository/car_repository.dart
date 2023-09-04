// ignore_for_file: unused_local_variable, avoid_print

import 'package:antique_jo/api_manager/push_notification_api.dart';
import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarRepository {
  static Future<bool> isCarDataUploadedToFirestor(
      {required CarInfo car}) async {
    String carName = car.carName;
    String carType = car.carType;
    String carModel = car.carModel;
    String carPrice = car.carPrice;
    String carImage = car.carImage;
    String carUUID = car.carUUID;
    // String ownerID = car.ownerID;
    String customerUID = car.customerID;
    bool isBooked = car.isBooked;
    int selectedColor = car.selectedColor;

    int selectedType = car.selectedType;

    try {
      await SharedPreferenceManager.saveString(key: 'carUID', value: carUUID);
      String ownerUIID =
          await SharedPreferenceManager.getString(key: 'currentUID');
      CollectionReference car = FirebaseFirestore.instance.collection('cars');
      String carUID = carUUID;

      Map<String, dynamic> carDataForFirestore = {
        'Car Name': carName,
        'Car type': carType,
        'Car model': carModel,
        'Car price': carPrice,
        'car Image': carImage,
        'Car UID': carUID,
        'ownerUID': ownerUIID,
        'customerUID': customerUID,
        'is booked': isBooked,
        'selectedColor': selectedColor,
        'selectedType': selectedType,
      };
      await car.doc(carUID).set(carDataForFirestore);
      await FirebaseMessageApi.sendFCMNotification(
        titleMessage: 'Antique Jo',
        bodyMessage: 'New car in app ',
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateCar(String documentId, CarInfo newData) async {
    String ownerUIID =
        await SharedPreferenceManager.getString(key: 'currentUID');

    Map<String, dynamic> carDataForFirestore = {
      'Car Name': newData.carName,
      'Car type': newData.carType,
      'Car model': newData.carModel,
      'Car price': newData.carPrice,
      'car Image': newData.carImage,
      'Car UID': newData.carUUID,
      'ownerUID': ownerUIID,
      'is booked': newData.isBooked,
      'selectedColor': newData.selectedColor,
      'selectedType': newData.selectedType,
    };
    try {
      await FirebaseFirestore.instance
          .collection('cars')
          .doc(documentId)
          .update(carDataForFirestore);
      print('Document updated successfully');
      return true;
    } catch (error) {
      print('Error updating document: $error');
      return false;
    }
  }
}
