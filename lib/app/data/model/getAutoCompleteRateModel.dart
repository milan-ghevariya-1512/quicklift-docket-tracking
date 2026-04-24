class GetAutoCompleteRateTypeModel{
  int? statusCode;
  bool? success;
  String? message;
  List<RateTypeList>? rateList;

  GetAutoCompleteRateTypeModel(
      {this.statusCode, this.message, this.rateList, this.success});

  factory GetAutoCompleteRateTypeModel.fromJson(Map<String, dynamic> json) {
    List data = json['Data'] is List ? json['Data'] ?? [] : [];
    List<RateTypeList> brokerList = data.map((e) => RateTypeList.fromJson(e)).toList();
    return GetAutoCompleteRateTypeModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        rateList : brokerList
    );
  }
}

class RateTypeList {
  String? codeId;
  String? codeDesc;

  RateTypeList({
    this.codeId,
    this.codeDesc,
  });

  factory RateTypeList.fromJson(Map<String, dynamic> json) {
    return RateTypeList(
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
    );
  }

}