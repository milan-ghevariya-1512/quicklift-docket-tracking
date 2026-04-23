class GetAutoCompleteLegLocationModel{
  int? statusCode;
  bool? success;
  String? message;
  List<LegLocationList>? legLocationList;

  GetAutoCompleteLegLocationModel(
      {this.statusCode, this.message, this.legLocationList, this.success});

  factory GetAutoCompleteLegLocationModel.fromJson(Map<String, dynamic> json) {
    List data = json['Data'] is List ? json['Data'] ?? [] : [];
    List<LegLocationList> brokerList = data.map((e) => LegLocationList.fromJson(e)).toList();
    return GetAutoCompleteLegLocationModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        legLocationList : brokerList
    );
  }
}

class LegLocationList {
  String? address;
  String? cityName;
  String? cityId;
  String? pinCodeId;
  String? pinCode;
  String? mobileNo;
  String? phoneNumber;
  String? manualCode;
  String? codeId;
  String? codeDesc;
  String? emailAddress;
  String? latitude;
  String? longitude;
  String? radius;
  String? addressType;

  LegLocationList({
    this.address,
    this.cityName,
    this.cityId,
    this.pinCodeId,
    this.pinCode,
    this.mobileNo,
    this.phoneNumber,
    this.manualCode,
    this.codeId,
    this.codeDesc,
    this.emailAddress,
    this.latitude,
    this.longitude,
    this.radius,
    this.addressType,
  });

  factory LegLocationList.fromJson(Map<String, dynamic> json) {
    return LegLocationList(
      address: (json['Address'] ?? '').toString(),
      cityName: (json['CityName'] ?? '').toString(),
      cityId: (json['CityId'] ?? '').toString(),
      pinCodeId: (json['PinCodeId'] ?? '').toString(),
      pinCode: (json['PinCode'] ?? '').toString(),
      mobileNo: (json['MobileNumber'] ?? '').toString(),
      phoneNumber: (json['PhoneNumber'] ?? '').toString(),
      manualCode: (json['ManualCode'] ?? '').toString(),
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
      emailAddress: (json['EmailAddress'] ?? '').toString(),
      latitude: (json['Latitude'] ?? 0).toString(),
      longitude: (json['Longitude'] ?? 0).toString(),
      radius: (json['Radius'] ?? 0).toString(),
      addressType: (json['AddressType'] ?? '').toString(),
    );
  }
}