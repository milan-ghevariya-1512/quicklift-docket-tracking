class GetAutoCompleteCustomerModel {
  String? cityName;
  String? cityId;
  String? pinCodeId;
  String? pinCode;
  String? areaName;
  String? areaId;
  String? operationAddress;
  String? eMail;
  String? mobileNo;
  String? mobileNos;
  String? decisionMakerMobile;
  String? salesPersonId;
  String? salesPerson;
  String? customerRefNumberPrefix;
  String? docketPrefix;
  String? billingAddress;
  String? customerBillingPartyTypeId;
  String? customerBillingPartyId;
  String? customerBillingPartyCode;
  String? customerBillingPartyName;
  String? invoiceDueDateBasedOn;
  String? serviceTypeId;
  String? bookingTypeAs;
  String? invoiceGstBillingTypeId;
  String? exemptedCategoryId;
  String? serviceCodeId;
  String? customerCompanyGstIds;
  String? customerCompanyStateIds;
  String? panNumber;
  String? collectionLocationId;
  String? transportModeId;
  String? allowedPayBase;
  String? customerCode;
  String? poNumber;
  String? codeId;
  String? codeDesc;
  bool isAutoTFNInvoice;
  bool isManageWithoutDCR;
  bool isContractParty;
  bool isConsignor;
  bool isConsignee;
  bool isPodUploadMandatoryForTfn;
  bool isSingleDocketSingleInvoice;

  GetAutoCompleteCustomerModel({
    this.cityName,
    this.cityId,
    this.pinCodeId,
    this.pinCode,
    this.areaName,
    this.areaId,
    this.operationAddress,
    this.eMail,
    this.mobileNo,
    this.mobileNos,
    this.decisionMakerMobile,
    this.salesPersonId,
    this.salesPerson,
    this.customerRefNumberPrefix,
    this.docketPrefix,
    this.billingAddress,
    this.customerBillingPartyTypeId,
    this.customerBillingPartyId,
    this.customerBillingPartyCode,
    this.customerBillingPartyName,
    this.invoiceDueDateBasedOn,
    this.serviceTypeId,
    this.bookingTypeAs,
    this.invoiceGstBillingTypeId,
    this.exemptedCategoryId,
    this.serviceCodeId,
    this.customerCompanyGstIds,
    this.customerCompanyStateIds,
    this.panNumber,
    this.collectionLocationId,
    this.transportModeId,
    this.allowedPayBase,
    this.customerCode,
    this.poNumber,
    this.codeId,
    this.codeDesc,
    this.isAutoTFNInvoice = false,
    this.isManageWithoutDCR = false,
    this.isContractParty = false,
    this.isConsignor = false,
    this.isConsignee = false,
    this.isPodUploadMandatoryForTfn = false,
    this.isSingleDocketSingleInvoice = false,
  });

  factory GetAutoCompleteCustomerModel.fromJson(Map<String, dynamic> json) {
    return GetAutoCompleteCustomerModel(
      cityName: (json['CityName'] ?? '').toString(),
      cityId: (json['CityId'] ?? '').toString(),
      pinCodeId: (json['PinCodeId'] ?? '').toString(),
      pinCode: (json['PinCode'] ?? '').toString(),
      areaName: (json['AreaName'] ?? '').toString(),
      areaId: (json['AreaId'] ?? '').toString(),
      operationAddress: (json['OperationAddress'] ?? '').toString(),
      eMail: (json['EMail'] ?? '').toString(),
      mobileNo: (json['MobileNo'] ?? '').toString(),
      mobileNos: (json['MobileNos'] ?? '').toString(),
      decisionMakerMobile: (json['DecisionMakerMobile'] ?? '').toString(),
      salesPersonId: (json['SalesPersonId'] ?? '').toString(),
      salesPerson: (json['SalesPerson'] ?? '').toString(),
      customerRefNumberPrefix: (json['CustomerRefNumberPrefix'] ?? '').toString(),
      docketPrefix: (json['DocketPrefix'] ?? '').toString(),
      billingAddress: (json['BillingAddress'] ?? '').toString(),
      customerBillingPartyTypeId: (json['CustomerBillingPartyTypeId'] ?? '').toString(),
      customerBillingPartyId: (json['CustomerBillingPartyId'] ?? '').toString(),
      customerBillingPartyCode: (json['CustomerBillingPartyCode'] ?? '').toString(),
      customerBillingPartyName: (json['CustomerBillingPartyName'] ?? '').toString(),
      invoiceDueDateBasedOn: (json['InvoiceDueDateBasedOn'] ?? '').toString(),
      serviceTypeId: (json['ServiceTypeId'] ?? '').toString(),
      bookingTypeAs: (json['BookingTypeAs'] ?? '').toString(),
      invoiceGstBillingTypeId: (json['InvoiceGstBillingTypeId'] ?? '').toString(),
      exemptedCategoryId: (json['ExemptedCategoryId'] ?? '').toString(),
      serviceCodeId: (json['ServiceCodeId'] ?? '').toString(),
      customerCompanyGstIds: (json['CustomerCompanyGstIds'] ?? '').toString(),
      customerCompanyStateIds: (json['CustomerCompanyStateIds'] ?? '').toString(),
      panNumber: (json['PANNumber'] ?? '').toString(),
      collectionLocationId: (json['CollectionLocationId'] ?? '').toString(),
      transportModeId: (json['TransportModeId'] ?? '').toString(),
      allowedPayBase: (json['AllowedPayBase'] ?? '').toString(),
      customerCode: (json['CustomerCode'] ?? '').toString(),
      poNumber: (json['PONumber'] ?? '').toString(),
      codeId: (json['CodeId'] ?? '').toString(),
      codeDesc: (json['CodeDesc'] ?? '').toString(),
      isAutoTFNInvoice: json['IsAutoTFNInvoice'] ?? false,
      isManageWithoutDCR: json['IsManageWithoutDCR'] ?? false,
      isContractParty: json['IsContractParty'] ?? false,
      isConsignor: json['IsConsignor'] ?? false,
      isConsignee: json['IsConsignee'] ?? false,
      isPodUploadMandatoryForTfn: json['IsPodUploadMandatoryForTfn'] ?? false,
      isSingleDocketSingleInvoice: json['IsSingleDocketSingleInvoice'] ?? false,
    );
  }
}