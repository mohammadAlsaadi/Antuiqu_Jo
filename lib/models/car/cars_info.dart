class CarInfo {
  String carType;
  String carColor;
  String carModel;
  String carName;
  String carImage;
  String carUUID;
  String ownerID;
  String customerID;
  bool isBooked;
  CarInfo({
    required this.carType,
    required this.carColor,
    required this.carModel,
    required this.carName,
    required this.carImage,
    required this.carUUID,
    required this.ownerID,
    required this.customerID,
    required this.isBooked,
  });

  Map<String, dynamic> toJosn() {
    return {
      'carType': carType,
      'carColor': carColor,
      'carModel': carModel,
      'carName': carName,
      'carImage': carImage,
      'carUUID': carUUID,
      'ownerID': ownerID,
      'customerID': customerID,
      'isBooked': isBooked,
    };
  }

  factory CarInfo.fromJson(Map<String, dynamic> json) {
    return CarInfo(
        carType: json['carType'],
        carColor: json['carColor'],
        carModel: json['carModel'],
        carName: json['carName'],
        carImage: json['carImage'],
        carUUID: json['carUUID'],
        ownerID: json['ownerID'],
        customerID: json['customerID'],
        isBooked: json['isBooked']);
  }
}
