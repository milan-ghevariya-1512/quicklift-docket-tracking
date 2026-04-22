class GetLocationModel{
  int? statusCode;
  bool? success;
  String? message;
  List<GetAutoCompleteLocationModel>? locationList;

  GetLocationModel(
      {this.statusCode, this.message, this.locationList, this.success});

  factory GetLocationModel.fromJson(Map<String, dynamic> json) {
    List data = json['Data'] is List ? json['Data'] ?? [] : [];
    List<GetAutoCompleteLocationModel> brokerList = data.map((e) => GetAutoCompleteLocationModel.fromJson(e)).toList();
    return GetLocationModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        locationList : brokerList
    );
  }
}

class GetAutoCompleteLocationModel {
  String? locationCode;
  String? currencyId;
  String? locationLevelDesc;
  String? stateId;
  String? codeId;
  String? codeDesc;
  bool? isHeadQuater;

  GetAutoCompleteLocationModel({
    this.locationCode,
    this.currencyId,
    this.locationLevelDesc,
    this.stateId,
    this.codeId,
    this.codeDesc,
    this.isHeadQuater,
  });

  factory GetAutoCompleteLocationModel.fromJson(Map<String, dynamic> json) {
    return GetAutoCompleteLocationModel(
      locationCode: (json['LocationCode'] ?? '').toString(),
      currencyId: (json['CurrencyId'] ?? '').toString(),
      locationLevelDesc: (json['LocationLevelDesc'] ?? '').toString(),
      stateId: (json['StateId'] ?? '').toString(),
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
      isHeadQuater: json['IsHeadQuater'] ?? false,
    );
  }

}