class GetGeneralMasterModel{
  String? typeId;
  String? typeName;
  String? codeId;
  String? codeDetail;
  String? srNo;

  GetGeneralMasterModel(
      {this.typeId, this.typeName, this.codeId, this.codeDetail, this.srNo});

  factory GetGeneralMasterModel.fromJson(Map<String, dynamic> json) {
    return GetGeneralMasterModel(
      typeId : (json['TypeId'] ?? '').toString(),
      typeName : (json['TypeName'] ?? '').toString(),
      codeId : (json['CodeId'] ?? '').toString(),
      codeDetail : (json['CodeDetail'] ?? '').toString(),
      srNo : (json['SrNo'] ?? '').toString(),
    );
  }
}