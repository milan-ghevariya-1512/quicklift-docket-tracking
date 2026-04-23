class GetAutoCompleteVehicleModel {
  String? vehicleCapacity;
  String? ftlTypeId;
  String? codeId;
  String? codeDesc;

  GetAutoCompleteVehicleModel({
    this.vehicleCapacity,
    this.ftlTypeId,
    this.codeId,
    this.codeDesc
  });

  factory GetAutoCompleteVehicleModel.fromJson(Map<String, dynamic> json) {
    return GetAutoCompleteVehicleModel(
      vehicleCapacity: (json['VehicleCapacity'] ?? '').toString(),
      ftlTypeId: (json['FtlTypeId'] ?? '').toString(),
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
    );
  }

}