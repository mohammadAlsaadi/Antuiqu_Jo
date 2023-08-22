// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnersInfo extends Equatable {
  final String? ownerUUID;
  final String ownerEmail;
  final String ownerPassword;

  final String ownerFullName;
  final String ownerPhoneNumber;
  final String ownerShopName;

  const OwnersInfo(
      {this.ownerUUID,
      this.ownerEmail = '',
      this.ownerPassword = '',
      this.ownerFullName = '',
      this.ownerPhoneNumber = '',
      this.ownerShopName = ''});

  OwnersInfo copyWith(
      {String? ownerUUID,
      String? ownerEmail,
      String? ownerPassword,
      String? ownerFullName,
      String? ownerPhoneNumber,
      String? ownerShopName}) {
    return OwnersInfo(
        ownerUUID: ownerUUID ?? this.ownerUUID,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        ownerPassword: ownerPassword ?? this.ownerPassword,
        ownerFullName: ownerFullName ?? this.ownerFullName,
        ownerPhoneNumber: ownerPhoneNumber ?? this.ownerPhoneNumber,
        ownerShopName: ownerShopName ?? this.ownerShopName);
  }

  factory OwnersInfo.fromSnapshot(DocumentSnapshot snap) {
    return OwnersInfo(
      ownerUUID: snap['ownerUUID'],
      ownerEmail: snap['ownerEmail'],
      ownerPassword: snap['ownerPassword'],
      ownerFullName: snap['ownerFullName'],
      ownerPhoneNumber: snap['ownerPhoneNumber'],
      ownerShopName: snap['ownerShopName'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'ownerEmail': ownerEmail,
      'ownerPassword': ownerPassword,
      'ownerFullName': ownerFullName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'ownerShopName': ownerShopName,
    };
  }

  @override
  List<Object?> get props => [
        ownerUUID,
        ownerEmail,
        ownerPassword,
        ownerFullName,
        ownerPhoneNumber,
        ownerShopName
      ];
}
