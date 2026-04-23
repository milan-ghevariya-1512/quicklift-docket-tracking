class GetLoginClaimModel {
  String? organizationId;
  String? companyId;
  String? userId;
  String? userName;
  String? roleId;
  String? companyCode;
  String? companyName;
  String? defaultLocationId;
  String? defaultLocationLevelNo;
  String? timeZoneDisplayName;
  String? timeZoneId;
  String? language;
  String? baseCurrency;
  String? localCurrency;
  String? currentFinancialYear;
  String? currentFinancialYearCode;
  String? currentFinancialFromDate;
  String? currentFinancialToDate;
  String? currentFinancialYearText;
  String? loginTypeId;
  String? isDriver;
  String? authenticationType;
  String? currencyName;
  String? currencyCode;
  String? currencyIcon;
  String? currentLocationId;
  String? currentLocationCode;
  String? currentLocationName;

  GetLoginClaimModel({
    this.organizationId,
    this.companyId,
    this.userId,
    this.userName,
    this.roleId,
    this.companyCode,
    this.companyName,
    this.defaultLocationId,
    this.defaultLocationLevelNo,
    this.timeZoneDisplayName,
    this.timeZoneId,
    this.language,
    this.baseCurrency,
    this.localCurrency,
    this.currentFinancialYear,
    this.currentFinancialYearCode,
    this.currentFinancialFromDate,
    this.currentFinancialToDate,
    this.currentFinancialYearText,
    this.loginTypeId,
    this.isDriver,
    this.authenticationType,
    this.currencyName,
    this.currencyCode,
    this.currencyIcon,
    this.currentLocationId,
    this.currentLocationCode,
    this.currentLocationName,
  });

  factory GetLoginClaimModel.fromJson(Map<String, dynamic> json) {
    return GetLoginClaimModel(
      organizationId: (json['OrganizationId'] ?? '').toString(),
      companyId: (json['CompanyId'] ?? '').toString(),
      userId: (json['UserId'] ?? '').toString(),
      userName: (json['UserName'] ?? '').toString(),
      roleId: (json['RoleId'] ?? '').toString(),
      companyCode: (json['CompanyCode'] ?? '').toString(),
      companyName: (json['CompanyName'] ?? '').toString(),
      defaultLocationId: (json['DefaultLocationId'] ?? '').toString(),
      defaultLocationLevelNo: (json['DefaultLocationLevelNo'] ?? '').toString(),
      timeZoneDisplayName: (json['TimeZoneDisplayName'] ?? '').toString(),
      timeZoneId: (json['TimeZoneId'] ?? '').toString(),
      language: (json['Language'] ?? '').toString(),
      baseCurrency: (json['BaseCurrency'] ?? '').toString(),
      localCurrency: (json['LocalCurrency'] ?? '').toString(),
      currentFinancialYear: (json['CurrentFinancialYear'] ?? '').toString(),
      currentFinancialYearCode: (json['CurrentFinancialYearCode'] ?? '').toString(),
      currentFinancialFromDate: (json['CurrentFinancialFromDate'] ?? '').toString(),
      currentFinancialToDate: (json['CurrentFinancialToDate'] ?? '').toString(),
      currentFinancialYearText: (json['CurrentFinancialYearText'] ?? '').toString(),
      loginTypeId: (json['LoginTypeId'] ?? '').toString(),
      isDriver: (json['IsDriver'] ?? '').toString(),
      authenticationType: (json['AuthenticationType'] ?? '').toString(),
      currencyName: (json['CurrencyName'] ?? '').toString(),
      currencyCode: (json['CurrencyCode'] ?? '').toString(),
      currencyIcon: (json['CurrencyICon'] ?? '').toString(),
      currentLocationId: (json['CurrentLocationId'] ?? '').toString(),
      currentLocationCode: (json['CurrentLocationCode'] ?? '').toString(),
      currentLocationName: (json['CurrentLocationName'] ?? '').toString(),
    );
  }
}