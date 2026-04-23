class GetServiceModeModel{
  int? statusCode;
  bool? success;
  String? message;
  List<ServiceModeList>? serviceList;

  GetServiceModeModel(
      {this.statusCode, this.message, this.serviceList, this.success});

  factory GetServiceModeModel.fromJson(Map<String, dynamic> json) {
    List data = json['Data'] is List ? json['Data'] ?? [] : [];
    List<ServiceModeList> brokerList = data.map((e) => ServiceModeList.fromJson(e)).toList();
    return GetServiceModeModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        serviceList : brokerList
    );
  }
}

class ServiceModeList {
  String? codeId;
  String? codeDesc;

  ServiceModeList({
    this.codeId,
    this.codeDesc,
  });

  factory ServiceModeList.fromJson(Map<String, dynamic> json) {
    return ServiceModeList(
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
    );
  }
}