// ignore_for_file: public_member_api_docs, sort_constructors_first
class OwnersInfo {
  String ownerEmail;
  String ownerPassword;
  String ownerUUID;
  String ownerFullName;
  String ownerPhoneNumber;
  String ownerShopName;

  OwnersInfo({
    required this.ownerEmail,
    required this.ownerPassword,
    required this.ownerUUID,
    required this.ownerFullName,
    required this.ownerPhoneNumber,
    required this.ownerShopName,
  });

  Map<String, dynamic> toJosn() {
    return {
      'ownerEmail': ownerEmail,
      'ownerPassword': ownerPassword,
      'ownerUUID': ownerUUID,
      'ownerFullName': ownerFullName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'ownerShopName': ownerShopName,
    };
  }

  factory OwnersInfo.fromJson(Map<String, dynamic> json) {
    return OwnersInfo(
      ownerEmail: json['ownerEmail'],
      ownerPassword: json['ownerPassword'],
      ownerUUID: json['ownerUUID'],
      ownerFullName: json['ownerFullName'],
      ownerPhoneNumber: json['ownerPhoneNumber'],
      ownerShopName: json['ownerShopName'],
    );
  }
}
