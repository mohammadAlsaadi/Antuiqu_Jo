import 'package:antique_jo/models/owner/owners_info.dart';

abstract class FirebaseOwnerRepository {
  Stream<OwnersInfo> getUser(String ownerId);
  Future<void> createOwner(OwnersInfo owner);
  Future<void> updateOner(OwnersInfo owner);
}
