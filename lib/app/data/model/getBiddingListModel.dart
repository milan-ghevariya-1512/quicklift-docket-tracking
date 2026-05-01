class GetVehicleRequestModel{
  int? statusCode;
  bool? success;
  String? message;
  BiddingData? biddingData;

  GetVehicleRequestModel(
      {this.statusCode, this.message, this.success, this.biddingData});

  factory GetVehicleRequestModel.fromJson(Map<String, dynamic> json) {
    return GetVehicleRequestModel(
        statusCode : json['StatusCode'] ?? 200,
        message : json['Message'] ?? '',
        success : json['Success'] ?? false,
        biddingData : json['Data'] == null ? null : BiddingData.fromJson(json['Data'])
    );
  }
}

class BiddingData{
  List<VehicleRequestsList>? vehicleRequestList;
  VehicleRequestCounts? vehicleRequestCounts;

  BiddingData({
    this.vehicleRequestList,
    this.vehicleRequestCounts
  });

  factory BiddingData.fromJson(Map<String, dynamic> json) {
    List data = json['VehicleRequests'] is List ? json['VehicleRequests'] ?? [] : [];
    List<VehicleRequestsList> bidList = data.map((e) => VehicleRequestsList.fromJson(e)).toList();
    return BiddingData(
      vehicleRequestList: bidList,
      vehicleRequestCounts: json['VehicleRequestCounts'] == null ? null : VehicleRequestCounts.fromJson(json['VehicleRequestCounts']),
    );
  }
}

class VehicleRequestsList {
  String? vrId;
  String? internalStatusId;
  String? companyId;
  String? vrNumber;
  String? manualNo;
  String? requestDate;
  String? expLoadingDate;
  String? expDeliveryTime;
  String? instructionForDriver;
  String? customerName;
  String? expectedReportingTime;
  bool isEarly;
  String? materialType;
  String? packagingType;
  String? startPoint;
  String? fromLocation;
  String? endPoint;
  String? toLocation;
  bool isBiddingRequired;
  String? bidStartDate;
  String? bidEndDate;
  bool isCapRate;
  String? maximumRate;
  String? biddingNote;
  String? ftlType;
  String? vehicleType;
  String? requiredNoOfVehicle;
  String? weight;
  String? acceptBidFrom;
  String? laneType;
  String? vendorId;
  bool isVendorReceivedOfferForThisRequest;
  bool isBidPlaced;
  String? reasonId;
  String? reasonText;
  bool isClose;
  String? requestGenerateBy;
  String? requestGenerateDate;
  String? approvedBy;
  String? approvedDateTime;
  String? vehicleUpdateBy;
  String? vehicleUpdateDate;
  String? vendorFreight;
  String? customerFreight;
  String? thcNo;
  String? thcId;
  String? docketNos;
  String? docketIds;
  String? vehicleReportingTime;

  VehicleRequestsList({
    this.vrId,
    this.internalStatusId,
    this.companyId,
    this.vrNumber,
    this.manualNo,
    this.requestDate,
    this.expLoadingDate,
    this.expDeliveryTime,
    this.instructionForDriver,
    this.customerName,
    this.expectedReportingTime,
    this.isEarly = false,
    this.materialType,
    this.packagingType,
    this.startPoint,
    this.fromLocation,
    this.endPoint,
    this.toLocation,
    this.isBiddingRequired = false,
    this.bidStartDate,
    this.bidEndDate,
    this.isCapRate = false,
    this.maximumRate,
    this.biddingNote,
    this.ftlType,
    this.vehicleType,
    this.requiredNoOfVehicle,
    this.weight,
    this.acceptBidFrom,
    this.laneType,
    this.vendorId,
    this.isVendorReceivedOfferForThisRequest = false,
    this.isBidPlaced = false,
    this.reasonId,
    this.reasonText,
    this.isClose = false,
    this.requestGenerateBy,
    this.requestGenerateDate,
    this.approvedBy,
    this.approvedDateTime,
    this.vehicleUpdateBy,
    this.vehicleUpdateDate,
    this.vendorFreight,
    this.customerFreight,
    this.thcNo,
    this.thcId,
    this.docketNos,
    this.docketIds,
    this.vehicleReportingTime,
  });

  factory VehicleRequestsList.fromJson(Map<String, dynamic> json) {
    return VehicleRequestsList(
      vrId: (json['VrId'] ?? '').toString(),
      internalStatusId: (json['InternalStatusId'] ?? '').toString(),
      companyId: (json['CompanyId'] ?? '').toString(),
      vrNumber: (json['VrNumber'] ?? '').toString(),
      manualNo: (json['ManualNo'] ?? '').toString(),
      requestDate: (json['RequestDate'] ?? '').toString(),
      expLoadingDate: (json['ExpLoadingDate'] ?? '').toString(),
      expDeliveryTime: (json['ExpDeliveryTime'] ?? '').toString(),
      instructionForDriver: (json['InstructionForDriver'] ?? '').toString(),
      customerName: (json['CustomerName'] ?? '').toString(),
      expectedReportingTime: (json['ExpectedReportingTime'] ?? '').toString(),
      isEarly: json['IsEarly'] ?? false,
      materialType: (json['MaterialType'] ?? '').toString(),
      packagingType: (json['PackagingType'] ?? '').toString(),
      startPoint: (json['StartPoint'] ?? '').toString(),
      fromLocation: (json['FromLocation'] ?? '').toString(),
      endPoint: (json['EndPoint'] ?? '').toString(),
      toLocation: (json['ToLocation'] ?? '').toString(),
      isBiddingRequired: json['IsBiddingRequired'] ?? false,
      bidStartDate: (json['BidStartDate'] ?? '').toString(),
      bidEndDate: (json['BidEndDate'] ?? '').toString(),
      isCapRate: json['IsCapRate'] ?? false,
      maximumRate: (json['MaximumRate'] ?? '').toString(),
      biddingNote: (json['BiddingNote'] ?? '').toString(),
      ftlType: (json['FtlType'] ?? '').toString(),
      vehicleType: (json['VehicleType'] ?? '').toString(),
      requiredNoOfVehicle: (json['RequiredNoOfVehicle'] ?? '').toString(),
      weight: (json['Weight'] ?? '').toString(),
      acceptBidFrom: (json['AcceptBidFrom'] ?? '').toString(),
      laneType: (json['LaneType'] ?? '').toString(),
      vendorId: (json['VendorId'] ?? '').toString(),
      isVendorReceivedOfferForThisRequest: json['IsVendorReceivedOfferForThisRequest'] ?? false,
      isBidPlaced: json['IsBidPlaced'] ?? false,
      reasonId: (json['ReasonId'] ?? '').toString(),
      reasonText: (json['ReasonText'] ?? '').toString(),
      isClose: json['IsClose'] ?? false,
      requestGenerateBy: (json['RequestGenerateBy'] ?? '').toString(),
      requestGenerateDate: (json['RequestGenerateDate'] ?? '').toString(),
      approvedBy: (json['ApprovedBy'] ?? '').toString(),
      approvedDateTime: (json['ApprovedDateTime'] ?? '').toString(),
      vehicleUpdateBy: (json['VehicleUpdateBy'] ?? '').toString(),
      vehicleUpdateDate: (json['VehicleUpdateDate'] ?? '').toString(),
      vendorFreight: (json['VendorFreight'] ?? '').toString(),
      customerFreight: (json['CustomerFreight'] ?? '').toString(),
      thcNo: (json['ThcNo'] ?? '').toString(),
      thcId: (json['ThcId'] ?? '').toString(),
      docketNos: (json['DocketNos'] ?? '').toString(),
      docketIds: (json['DocketIds'] ?? '').toString(),
      vehicleReportingTime: (json['VehicleReportingTime'] ?? '').toString(),
    );
  }
}

class VehicleRequestCounts {
  String? totalCount;
  String? generatedCount;
  String? inProcessCount;
  String? tripGeneratedCount;
  String? tripCancelledCount;
  String? tripCompletedCount;

  VehicleRequestCounts({
    this.totalCount,
    this.generatedCount,
    this.inProcessCount,
    this.tripGeneratedCount,
    this.tripCancelledCount,
    this.tripCompletedCount,
  });

  factory VehicleRequestCounts.fromJson(Map<String, dynamic> json) {
    return VehicleRequestCounts(
      totalCount: (json['TotalCount'] ?? '').toString(),
      generatedCount: (json['GeneratedCount'] ?? '').toString(),
      inProcessCount: (json['InProcessCount'] ?? '').toString(),
      tripGeneratedCount: (json['TripGeneratedCount'] ?? '').toString(),
      tripCancelledCount: (json['TripCancelledCount'] ?? '').toString(),
      tripCompletedCount: (json['TripCompletedCount'] ?? '').toString(),
    );
  }
}