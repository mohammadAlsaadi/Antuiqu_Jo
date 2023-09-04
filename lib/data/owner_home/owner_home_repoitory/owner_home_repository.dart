// ignore_for_file: avoid_print

import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerHomeRepository {
  static Future<List<CarInfo>> loadCarsFromFirestore() async {
    try {
      String currentOwnerUID =
          await SharedPreferenceManager.getString(key: 'currentUID');

      final QuerySnapshot<Map<String, dynamic>> documentsSnapshot =
          await FirebaseFirestore.instance
              .collection('cars')
              .where('ownerUID', isEqualTo: currentOwnerUID)
              .get();

      List<CarInfo> carModels = documentsSnapshot.docs.map((doc) {
        Map<String, dynamic> carData = doc.data();
        return CarInfo(
          carType: carData['Car type'],
          carColor: '',
          carModel: carData['Car model'],
          carName: carData['Car Name'],
          carPrice: carData['Car price'],
          carImage: carData['car Image'],
          carUUID: carData['Car UID'],
          ownerID: carData['ownerUID'],
          customerID: carData['customerUID'],
          isBooked: carData['is booked'],
          selectedColor: carData['selectedColor'],
          selectedType: carData['selectedType'],
        );
      }).toList();

      return carModels;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> deleteCarByDocumentUID(String documentUID) async {
    try {
      await FirebaseFirestore.instance
          .collection('cars')
          .doc(documentUID)
          .delete();
      return true;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }
}
