// ignore_for_file: avoid_print

import 'package:antique_jo/data/repository/owner_repository/firebase_owner_repository.dart';
import 'package:antique_jo/models/owner/owners_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerRepository extends FirebaseOwnerRepository {
  final FirebaseFirestore _firebaseFirestore;

  OwnerRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createOwner(OwnersInfo owner) async {
    await _firebaseFirestore
        .collection('owners')
        .doc(owner.ownerUUID)
        .set(owner.toDocument());
  }

  @override
  Stream<OwnersInfo> getUser(String ownerId) {
    return _firebaseFirestore
        .collection('owners')
        .doc(ownerId)
        .snapshots()
        .map((snap) => OwnersInfo.fromSnapshot(snap));
  }

  @override
  Future<void> updateOner(OwnersInfo owner) {
    return _firebaseFirestore
        .collection('owners')
        .doc(owner.ownerUUID)
        .update(owner.toDocument())
        .then((value) => print('owner document updated'));
  }
}
