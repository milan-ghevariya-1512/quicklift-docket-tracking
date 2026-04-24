class GetVehicleRequestModel{
  int? statusCode;
  bool? success;
  String? message;
  VehicleRequestData? vehicleRequestData;

  GetVehicleRequestModel(
      {this.statusCode, this.message, this.success, this.vehicleRequestData});

  factory GetVehicleRequestModel.fromJson(Map<String, dynamic> json) {
    return GetVehicleRequestModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        vehicleRequestData : json['Data'] == null ? null : VehicleRequestData.fromJson(json['Data'])
    );
  }
}

class VehicleRequestData{
  String? customerId;
  String? customerName;
  String? userId;
  String? userName;
  bool? isBiddingEnable;
  bool? isCustomerAddress;
  bool? isLegEnable;

  VehicleRequestData({
    this.userId,
    this.customerId,
    this.customerName,
    this.userName,
    this.isBiddingEnable,
    this.isCustomerAddress,
    this.isLegEnable,
  });

  factory VehicleRequestData.fromJson(Map<String, dynamic> json) {
    return VehicleRequestData(
      userId: (json['UserId'] ?? '').toString(),
      customerId: (json['CustomerId'] ?? '').toString(),
      customerName: (json['CustomerName'] ?? '').toString(),
      userName: (json['UserName'] ?? '').toString(),
      isBiddingEnable: json['IsBiddingEnable'] ?? false,
      isCustomerAddress: json['IsCustomerAddress'] ?? false,
      isLegEnable: json['IsLegEnable'] ?? false,
    );
  }
}