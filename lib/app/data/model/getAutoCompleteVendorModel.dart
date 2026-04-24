class GetAutoCompleteVendorModel{
  int? statusCode;
  bool? success;
  String? message;
  List<VendorTypeList>? vendorList;

  GetAutoCompleteVendorModel(
      {this.statusCode, this.message, this.vendorList, this.success});

  factory GetAutoCompleteVendorModel.fromJson(Map<String, dynamic> json) {
    List data = json['Data'] is List ? json['Data'] ?? [] : [];
    List<VendorTypeList> brokerList = data.map((e) => VendorTypeList.fromJson(e)).toList();
    return GetAutoCompleteVendorModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        vendorList : brokerList
    );
  }
}

class VendorTypeList {
  String? vendorCode;
  String? typeId;
  String? behaviour;
  String? codeId;
  String? codeDesc;

  VendorTypeList({
    this.vendorCode,
    this.typeId,
    this.behaviour,
    this.codeId,
    this.codeDesc,
  });

  factory VendorTypeList.fromJson(Map<String, dynamic> json) {
    return VendorTypeList(
      vendorCode: (json['VendorCode'] ?? '').toString(),
      typeId: (json['TypeId'] ?? '').toString(),
      behaviour: (json['Behaviour'] ?? '').toString(),
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
    );
  }

}