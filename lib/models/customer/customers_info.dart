// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomersInfo {
  String customerEmail;
  String customerPassword;
  String customerUUID;
  String customerFullName;
  String customerPhoneNumber;
  String? bookedCarID;
  String customerAge;
  String customerGender;
  CustomersInfo({
    required this.customerEmail,
    required this.customerPassword,
    required this.customerUUID,
    required this.customerFullName,
    required this.customerPhoneNumber,
    this.bookedCarID,
    required this.customerAge,
    required this.customerGender,
  });

  Map<String, dynamic> toJosn() {
    return {
      'customerEmail': customerEmail,
      'customerPassword': customerPassword,
      'customerUUID': customerUUID,
      'customerFullName': customerFullName,
      'customerPhoneNumber': customerPhoneNumber,
      'bookedCarID': bookedCarID,
      'customerAge': customerAge,
      'customerGender': customerGender,
    };
  }

  factory CustomersInfo.fromJson(Map<String, dynamic> json) {
    return CustomersInfo(
      customerEmail: json['customerEmail'],
      customerPassword: json['customerPassword'],
      customerUUID: json['customerUUID'],
      customerFullName: json['customerFullName'],
      customerPhoneNumber: json['customerPhoneNumber'],
      bookedCarID: json['bookedCarID'],
      customerAge: json['customerAge'],
      customerGender: json['customerGender'],
    );
  }
}
