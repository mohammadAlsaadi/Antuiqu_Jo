// ignore_for_file: file_names

class OwnerInfo {
  String ownerEmail;
  String ownerPassword;
  String ownerUUID;
  String ownerFullName;
  String ownerPhoneNumber;
  String ownerShopName;

  OwnerInfo({
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

  factory OwnerInfo.fromJson(Map<String, dynamic> json) {
    return OwnerInfo(
      ownerEmail: json['ownerEmail'],
      ownerPassword: json['ownerPassword'],
      ownerUUID: json['ownerUUID'],
      ownerFullName: json['ownerFullName'],
      ownerPhoneNumber: json['ownerPhoneNumber'],
      ownerShopName: json['ownerShopName'],
    );
  }
}
