class GetAutoCompleteCityModel {
  String? pinCode;
  String? pinCodeId;
  String? areaName;
  String? areaId;
  String? cityAbrv;
  bool? isGstCity;
  String? gstNumber;
  String? gstId;
  String? latitude;
  String? longitude;
  bool? toBeConsiderForAutoInvoice;
  String? codeId;
  String? codeDesc;

  GetAutoCompleteCityModel({
    this.pinCode,
    this.pinCodeId,
    this.areaName,
    this.areaId,
    this.cityAbrv,
    this.isGstCity,
    this.gstNumber,
    this.gstId,
    this.latitude,
    this.longitude,
    this.toBeConsiderForAutoInvoice,
    this.codeId,
    this.codeDesc,
  });

  factory GetAutoCompleteCityModel.fromJson(Map<String, dynamic> json) {
    return GetAutoCompleteCityModel(
      pinCode: (json['PinCode'] ?? '').toString(),
      pinCodeId: (json['PinCodeId'] ?? '').toString(),
      areaName: (json['AreaName'] ?? '').toString(),
      areaId: (json['AreaId'] ?? '').toString(),
      cityAbrv: (json['CityAbrv'] ?? '').toString(),
      isGstCity: json['IsGstCity'] ?? false,
      gstNumber: (json['GstNumber'] ?? '').toString(),
      gstId: (json['GstId'] ?? '').toString(),
      latitude: (json['Latitude'] ?? 0).toString(),
      longitude: (json['Longitude'] ?? 0).toString(),
      toBeConsiderForAutoInvoice: json['ToBeConsiderForAutoInvoice'] ?? false,
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
    );
  }

}