class GetFieldListModel{
  int? statusCode;
  bool? success;
  String? message;
  List<FieldSetupModel>? fieldList;

  GetFieldListModel(
      {this.statusCode, this.message, this.fieldList, this.success});

  factory GetFieldListModel.fromJson(Map<String, dynamic> json) {
    List data = json['Data'] is List ? json['Data'] ?? [] : [];
    List<FieldSetupModel> brokerList = data.map((e) => FieldSetupModel.fromJson(e)).toList();
    return GetFieldListModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        fieldList : brokerList
    );
  }
}

class FieldSetupModel {
  String fieldId;
  String fieldValueType;
  bool isInUse;
  bool isEnable;
  bool isRequired;
  String languageId;
  String fieldToolTip;
  String fieldCaption;

  FieldSetupModel({
    required this.fieldId,
    this.fieldValueType = '',
    this.isInUse = false,
    this.isEnable = false,
    this.isRequired = false,
    this.languageId = '',
    this.fieldToolTip = '',
    this.fieldCaption = '',
  });

  factory FieldSetupModel.fromJson(Map<String, dynamic> json) =>
      FieldSetupModel(
        fieldId: json["FieldId"] ?? '',
        fieldValueType: json["FieldValueType"] ?? '',
        isInUse: json["IsInUse"] ?? false,
        isEnable: json["IsEnable"] ?? false,
        isRequired: json["IsRequired"] ?? false,
        languageId: json["LanguageId"] ?? '',
        fieldToolTip: json["FieldToolTip"] ?? '',
        fieldCaption: json["FieldCaption"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "FieldId": fieldId,
    "FieldValueType": fieldValueType,
    "IsInUse": isInUse,
    "IsEnable": isEnable,
    "IsRequired": isRequired,
    "LanguageId": languageId,
    "FieldToolTip": fieldToolTip,
    "FieldCaption": fieldCaption,
  };
}