class GetVehicleFtlTypeModel{
  int? statusCode;
  bool? success;
  String? message;
  List<GetAutoCompleteVehicleFtlTypeList>? vehicleFtlTypeList;

  GetVehicleFtlTypeModel(
      {this.statusCode, this.message, this.vehicleFtlTypeList, this.success});

  factory GetVehicleFtlTypeModel.fromJson(Map<String, dynamic> json) {
    List data = json['Data'] is List ? json['Data'] ?? [] : [];
    List<GetAutoCompleteVehicleFtlTypeList> brokerList = data.map((e) => GetAutoCompleteVehicleFtlTypeList.fromJson(e)).toList();
    return GetVehicleFtlTypeModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        vehicleFtlTypeList : brokerList
    );
  }
}

class GetAutoCompleteVehicleFtlTypeList {
  String? codeId;
  String? codeDesc;
  String? ftlTypeCode;
  String? vehicleCapacity;

  GetAutoCompleteVehicleFtlTypeList({
    this.codeId,
    this.codeDesc,
    this.ftlTypeCode,
    this.vehicleCapacity,
  });

  factory GetAutoCompleteVehicleFtlTypeList.fromJson(Map<String, dynamic> json) {
    return GetAutoCompleteVehicleFtlTypeList(
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
      ftlTypeCode: (json['FtlTypeCode'] ?? '').toString(),
      vehicleCapacity: (json['VehicleCapacity'] ?? '').toString(),
    );
  }
}