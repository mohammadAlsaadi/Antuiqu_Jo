import 'package:cloud_firestore/cloud_firestore.dart';

class DetailRepository {
  static Future<Map<String, dynamic>> getCarDataByIndex(int index) async {
    final documentsSnapshot =
        await FirebaseFirestore.instance.collection('cars').get();

    if (index < documentsSnapshot.docs.length) {
      final documentData = documentsSnapshot.docs[index].data();
      return documentData;
    } else {
      return {};
    }
  }
}
