class GetDocketDetailsModel{
  ApiDocket? apiDocket;
  ApiDocketBooking? apiDocketBooking;
  ApiDocketBookingExtraDetails? apiDocketBookingExtraDetails;
  ApiDocketConsignorDetails? apiDocketConsignorDetails;
  ApiDocketConsigneeDetails? apiDocketConsigneeDetails;
  ApiDocketVendorHeader? apiDocketVendorHeader;
  List<ApiDocketInvoiceDetails>? apiDocketInvoiceDetails;
  List<ApiDocketInvoiceSummary>? apiDocketInvoiceSummary;
  List<ApiDocketEvents>? apiDocketEvents;
  List<ApiDocketDeliveryAttempts>? apiDocketDeliveryAttempts;

  GetDocketDetailsModel(
      {this.apiDocket,this.apiDocketBooking,this.apiDocketBookingExtraDetails,this.apiDocketConsignorDetails,this.apiDocketConsigneeDetails,this.apiDocketVendorHeader,this.apiDocketInvoiceDetails,this.apiDocketInvoiceSummary,this.apiDocketEvents,this.apiDocketDeliveryAttempts});

  factory GetDocketDetailsModel.fromJson(Map<String, dynamic> json) {
    List d1 = json['ApidocketInvoiceDetails'] is List ? json['ApidocketInvoiceDetails'] ?? [] : [];
    List<ApiDocketInvoiceDetails> data1 = d1.map((e) => ApiDocketInvoiceDetails.fromJson(e)).toList();
    List d2 = json['ApidocketInvoiceSummary'] is List ? json['ApidocketInvoiceSummary'] ?? [] : [];
    List<ApiDocketInvoiceSummary> data2 = d2.map((e) => ApiDocketInvoiceSummary.fromJson(e)).toList();
    List d3 = json['ApidocketEvents'] is List ? json['ApidocketEvents'] ?? [] : [];
    List<ApiDocketEvents> data3 = d3.map((e) => ApiDocketEvents.fromJson(e)).toList();
    List d4 = json['ApidocketDeliveryAttempts'] is List ? json['ApidocketDeliveryAttempts'] ?? [] : [];
    List<ApiDocketDeliveryAttempts> data4 = d4.map((e) => ApiDocketDeliveryAttempts.fromJson(e)).toList();
    return GetDocketDetailsModel(
      apiDocket: json['Apidocket'] == null ? null : ApiDocket.fromJson(json['Apidocket']),
      apiDocketBooking: json['ApidocketBooking'] == null ? null : ApiDocketBooking.fromJson(json['ApidocketBooking']),
      apiDocketBookingExtraDetails: json['ApidocketBookingExtraDetails'] == null ? null : ApiDocketBookingExtraDetails.fromJson(json['ApidocketBookingExtraDetails']),
      apiDocketConsignorDetails: json['ApidocketConsignorDetai'] == null ? null : ApiDocketConsignorDetails.fromJson(json['ApidocketConsignorDetai']),
      apiDocketConsigneeDetails: json['ApidocketConsigneeDetail'] == null ? null : ApiDocketConsigneeDetails.fromJson(json['ApidocketConsigneeDetail']),
      apiDocketVendorHeader: json['ApidocketVendorHeader'] == null ? null : ApiDocketVendorHeader.fromJson(json['ApidocketVendorHeader']),
      apiDocketInvoiceDetails: data1,
      apiDocketInvoiceSummary: data2,
      apiDocketEvents: data3,
      apiDocketDeliveryAttempts: data4
    );
  }

}

class ApiDocket{
  String? originLocationCode;
  String? destinationLocationCode;
  String? originLocationText;
  String? originLocationName;
  String? originMobileNumber;
  String? originLocationAddress;
  String? destinationLocationText;
  String? destinationLocationName;
  String? destinationMobileNumber;
  String? originPinCodeText;
  String? destinationPinCodeText;
  String? originPinCode;
  String? destinationPinCode;
  String? originCityText;
  String? destinationCityText;
  String? companyName;
  String? companyAddress;
  String? companyPanNo;
  String? companyFirstGstNo;
  String? companyTagLine;
  String? gstPayBy;
  String? pvtMarka;
  String? updatedBy;
  String? updatedDateTime;

  ApiDocket(
      {this.originLocationCode,
        this.destinationLocationCode,
        this.originLocationText,
        this.originLocationName,
        this.originMobileNumber,
        this.originLocationAddress,
        this.destinationLocationText,
        this.destinationLocationName,
        this.destinationMobileNumber,
        this.originPinCodeText,
        this.destinationPinCodeText,
        this.originPinCode,
        this.destinationPinCode,
        this.originCityText,
        this.destinationCityText,
        this.companyName,
        this.companyAddress,
        this.companyPanNo,
        this.companyFirstGstNo,
        this.companyTagLine,
        this.gstPayBy,
        this.pvtMarka,
        this.updatedBy,
        this.updatedDateTime,
      });

  factory ApiDocket.fromJson(Map<String, dynamic> json) {
    return ApiDocket(
      originLocationCode: (json['origin_location_code'] ?? '').toString(),
      destinationLocationCode: (json['destination_location_code'] ?? '').toString(),
      originLocationText: (json['origin_location_text'] ?? '').toString(),
      originLocationName: (json['origin_location_name'] ?? '').toString(),
      originMobileNumber: (json['origin_mobile_number'] ?? '').toString(),
      originLocationAddress: (json['origin_location_address'] ?? '').toString(),
      destinationLocationText: (json['destination_location_text'] ?? '').toString(),
      destinationLocationName: (json['destination_location_name'] ?? '').toString(),
      destinationMobileNumber: (json['destination_mobile_number'] ?? '').toString(),
      originPinCodeText: (json['origin_pin_code_text'] ?? '').toString(),
      destinationPinCodeText: (json['destination_pin_code_text'] ?? '').toString(),
      originPinCode: (json['origin_pin_code'] ?? '').toString(),
      destinationPinCode: (json['destination_pin_code'] ?? '').toString(),
      originCityText: (json['origin_city_text'] ?? '').toString(),
      destinationCityText: (json['destination_city_text'] ?? '').toString(),
      companyName: (json['company_name'] ?? '').toString(),
      companyAddress: (json['company_address'] ?? '').toString(),
      companyPanNo: (json['company_pan_no'] ?? '').toString(),
      companyFirstGstNo: (json['company_first_gst_no'] ?? '').toString(),
      companyTagLine: (json['company_tag_line'] ?? '').toString(),
      gstPayBy: (json['gst_pay_by'] ?? '').toString(),
      pvtMarka: (json['pvt_marka'] ?? '').toString(),
      updatedBy: (json['updated_by'] ?? '').toString(),
      updatedDateTime: (json['updated_date_time'] ?? '').toString(),
    );
  }
}

class ApiDocketBooking{
  String? docketId;
  String? paymentTypeCode;
  String? transportMode;
  String? serviceMode;
  String? ftlTypeId;
  String? cargoCategoryId;
  String? businessTypeId;
  String? pickup_type_code;
  String? packaging_type_id;
  String? product_type_id;
  bool? is_com;
  String? com_to_collect;
  String? com_currency_id;
  String? order_no;
  String? order_date;
  String? total_invoice_value;
  String? total_packages_no;
  String? total_actual_weight;
  String? total_volumatric_weight;
  String? total_calculated_volumatric_weight;
  String? contract_party_id;
  String? billing_party_id;
  String? billing_weight;
  bool? is_local_docket;
  bool? is_nc_nd;
  bool? is_oda;
  bool? is_opa;
  bool? is_odc;
  bool? is_charge_applicable_sc017;
  bool? is_charge_applicable_sc018;
  bool? is_charge_applicable_sc019;
  String? updated_by;
  String? updated_date_time;
  String? current_module_code;
  String? load_type_id;
  String? edd_date;
  bool? is_cancelled;
  String? module_template_id;
  String? billing_party_contract_id;
  String? default_contract_id;
  String? contract_id;
  String? delivery_process_id;
  String? docket_type;
  String? contract_party_name;
  String? contract_party_code;
  String? payment_type_name;
  String? transport_mode_name;
  String? service_mode_name;
  String? pickup_type_name;
  String? billing_party_name;
  String? billing_party_code;
  String? packaging_type;
  String? com_currency;
  String? edd_date_time;
  String? allowed_rate_types;
  String? delivery_process_name;
  String? docket_type_text;

  ApiDocketBooking(
      {this.docketId,
        this.paymentTypeCode,
        this.transportMode,
        this.serviceMode,
        this.ftlTypeId,
        this.cargoCategoryId,
        this.businessTypeId,
        this.pickup_type_code,
        this.packaging_type_id,
        this.product_type_id,
        this.is_com,
        this.com_to_collect,
        this.com_currency_id,
        this.order_no,
        this.order_date,
        this.total_invoice_value,
        this.total_packages_no,
        this.total_actual_weight,
        this.total_volumatric_weight,
        this.total_calculated_volumatric_weight,
        this.contract_party_id,
        this.billing_party_id,
        this.billing_weight,
        this.is_local_docket,
        this.is_nc_nd,
        this.is_oda,
        this.is_opa,
        this.is_odc,
        this.is_charge_applicable_sc017,
        this.is_charge_applicable_sc018,
        this.is_charge_applicable_sc019,
        this.updated_by,
        this.updated_date_time,
        this.current_module_code,
        this.load_type_id,
        this.edd_date,
        this.is_cancelled,
        this.module_template_id,
        this.billing_party_contract_id,
        this.default_contract_id,
        this.contract_id,
        this.delivery_process_id,
        this.docket_type,
        this.contract_party_name,
        this.contract_party_code,
        this.payment_type_name,
        this.transport_mode_name,
        this.service_mode_name,
        this.pickup_type_name,
        this.billing_party_name,
        this.billing_party_code,
        this.packaging_type,
        this.com_currency,
        this.edd_date_time,
        this.allowed_rate_types,
        this.delivery_process_name,
        this.docket_type_text,
      });

  factory ApiDocketBooking.fromJson(Map<String, dynamic> json) {
    return ApiDocketBooking(
      docketId : (json['docket_id'] ?? '').toString(),
      paymentTypeCode : (json['payment_type_code'] ?? '').toString(),
      transportMode : (json['transport_mode'] ?? '').toString(),
      serviceMode : (json['service_mode'] ?? '').toString(),
      ftlTypeId : (json['ftl_type_id'] ?? '').toString(),
      cargoCategoryId : (json['cargo_category_id'] ?? '').toString(),
      businessTypeId : (json['business_type_id'] ?? '').toString(),
      pickup_type_code : (json['pickup_type_code'] ?? '').toString(),
      packaging_type_id : (json['packaging_type_id'] ?? '').toString(),
      product_type_id : (json['product_type_id'] ?? '').toString(),
      is_com : json['is_com'] ?? false,
      com_to_collect : (json['com_to_collect'] ?? 0).toString(),
      com_currency_id : (json['com_currency_id'] ?? '').toString(),
      order_no : (json['order_no'] ?? '').toString(),
      order_date : (json['order_date'] ?? '').toString(),
      total_invoice_value : (json['total_invoice_value'] ?? '').toString(),
      total_packages_no : (json['total_packages_no'] ?? '').toString(),
      total_actual_weight : (json['total_actual_weight'] ?? '').toString(),
      total_volumatric_weight : (json['total_volumatric_weight'] ?? '').toString(),
      total_calculated_volumatric_weight : (json['total_calculated_volumatric_weight'] ?? '').toString(),
      contract_party_id : (json['contract_party_id'] ?? '').toString(),
      billing_party_id : (json['billing_party_id'] ?? '').toString(),
      billing_weight : (json['billing_weight'] ?? '').toString(),
      is_local_docket : json['is_local_docket'] ?? false,
      is_nc_nd : json['is_nc_nd'] ?? false,
      is_oda : json['is_oda'] ?? false,
      is_opa : json['is_opa'] ?? false,
      is_odc : json['is_odc'] ?? false,
      is_charge_applicable_sc017 : json['is_charge_applicable_sc017'] ?? false,
      is_charge_applicable_sc018 : json['is_charge_applicable_sc018'] ?? false,
      is_charge_applicable_sc019 : json['is_charge_applicable_sc019'] ?? false,
      updated_by : (json['updated_by'] ?? '').toString(),
      updated_date_time : (json['updated_date_time'] ?? '').toString(),
      current_module_code : (json['current_module_code'] ?? '').toString(),
      load_type_id : (json['load_type_id'] ?? '').toString(),
      edd_date : (json['edd_date'] ?? '').toString(),
      is_cancelled : json['is_cancelled'] ?? false,
      module_template_id : (json['module_template_id'] ?? '').toString(),
      billing_party_contract_id : (json['billing_party_contract_id'] ?? '').toString(),
      default_contract_id : (json['default_contract_id'] ?? '').toString(),
      contract_id : (json['contract_id'] ?? '').toString(),
      delivery_process_id : (json['delivery_process_id'] ?? '').toString(),
      docket_type : (json['docket_type'] ?? '').toString(),
      contract_party_name : (json['contract_party_name'] ?? '').toString(),
      contract_party_code : (json['contract_party_code'] ?? '').toString(),
      payment_type_name : (json['payment_type_name'] ?? '').toString(),
      transport_mode_name : (json['transport_mode_name'] ?? '').toString(),
      service_mode_name : (json['service_mode_name'] ?? '').toString(),
      pickup_type_name : (json['pickup_type_name'] ?? '').toString(),
      billing_party_name : (json['billing_party_name'] ?? '').toString(),
      billing_party_code : (json['billing_party_code'] ?? '').toString(),
      packaging_type : (json['packaging_type'] ?? '').toString(),
      com_currency : (json['com_currency'] ?? '').toString(),
      edd_date_time : (json['edd_date_time'] ?? '').toString(),
      allowed_rate_types : (json['allowed_rate_types'] ?? '').toString(),
      delivery_process_name : (json['delivery_process_name'] ?? '').toString(),
      docket_type_text : (json['docket_type_text'] ?? '').toString(),
    );
  }
}

class ApiDocketBookingExtraDetails{
  bool? is_permit_applicable;
  String? private_mark;

  ApiDocketBookingExtraDetails(
      {this.is_permit_applicable,
       this.private_mark,
      });

  factory ApiDocketBookingExtraDetails.fromJson(Map<String, dynamic> json) {
    return ApiDocketBookingExtraDetails(
      is_permit_applicable : json['is_permit_applicable'] ?? false,
      private_mark : (json['private_mark'] ?? '').toString(),
    );
  }
}

class ApiDocketConsignorDetails{
  String? docket_id;
  String? consignor_id;
  String? consignor_code;
  String? consignor_name;
  String? addresse_id;
  String? consignor_address;
  String? consignor_city_id;
  String? consignor_city;
  String? consignor_pin_code_id;
  String? consignor_pin_code;
  String? consignor_email;
  String? consignor_mobile_number;
  bool? is_consignor_from_master;

  ApiDocketConsignorDetails(
      {this.docket_id,
        this.consignor_id,
        this.consignor_code,
        this.consignor_name,
        this.addresse_id,
        this.consignor_address,
        this.consignor_city_id,
        this.consignor_city,
        this.consignor_pin_code_id,
        this.consignor_pin_code,
        this.consignor_email,
        this.consignor_mobile_number,
        this.is_consignor_from_master,
      });

  factory ApiDocketConsignorDetails.fromJson(Map<String, dynamic> json) {
    return ApiDocketConsignorDetails(
      docket_id : (json['docket_id'] ?? '').toString(),
      consignor_id : (json['consignor_id'] ?? '').toString(),
      consignor_code : (json['consignor_code'] ?? '').toString(),
      consignor_name : (json['consignor_name'] ?? '').toString(),
      addresse_id : (json['addresse_id'] ?? '').toString(),
      consignor_address : (json['consignor_address'] ?? '').toString(),
      consignor_city_id : (json['consignor_city_id'] ?? '').toString(),
      consignor_city : (json['consignor_city'] ?? '').toString(),
      consignor_pin_code_id : (json['consignor_pin_code_id'] ?? '').toString(),
      consignor_pin_code : (json['consignor_pin_code'] ?? '').toString(),
      consignor_email : (json['consignor_email'] ?? '').toString(),
      consignor_mobile_number : (json['consignor_mobile_number'] ?? '').toString(),
      is_consignor_from_master : json['is_consignor_from_master'] ?? false,
    );
  }
}

class ApiDocketConsigneeDetails{
  String? docket_id;
  String? consignee_id;
  String? consignee_code;
  String? consignee_name;
  String? consignee_address;
  String? consignee_pin_code_id;
  String? consignee_pin_code;
  String? consignee_email;
  String? consignee_mobile_number;
  String? consignee_gstin_number;
  bool? is_consignee_from_master;

  ApiDocketConsigneeDetails(
      {this.docket_id,
        this.consignee_id,
        this.consignee_code,
        this.consignee_name,
        this.consignee_address,
        this.consignee_pin_code_id,
        this.consignee_pin_code,
        this.consignee_email,
        this.consignee_mobile_number,
        this.consignee_gstin_number,
        this.is_consignee_from_master,
      });

  factory ApiDocketConsigneeDetails.fromJson(Map<String, dynamic> json) {
    return ApiDocketConsigneeDetails(
      docket_id : (json['docket_id'] ?? '').toString(),
      consignee_id : (json['consignee_id'] ?? '').toString(),
      consignee_code : (json['consignee_code'] ?? '').toString(),
      consignee_name : (json['consignee_name'] ?? '').toString(),
      consignee_address : (json['consignee_address'] ?? '').toString(),
      consignee_pin_code_id : (json['consignee_pin_code_id'] ?? '').toString(),
      consignee_pin_code : (json['consignee_pin_code'] ?? '').toString(),
      consignee_email : (json['consignee_email'] ?? '').toString(),
      consignee_mobile_number : (json['consignee_mobile_number'] ?? '').toString(),
      consignee_gstin_number : (json['consignee_gstin_number'] ?? '').toString(),
      is_consignee_from_master : json['is_consignee_from_master'] ?? false,
    );
  }
}

class ApiDocketVendorHeader{
  String? originLocationCode;

  ApiDocketVendorHeader(
      {this.originLocationCode,
      });

  factory ApiDocketVendorHeader.fromJson(Map<String, dynamic> json) {
    return ApiDocketVendorHeader(
      originLocationCode : json['origin_location_code'] ?? '',
    );
  }
}

class ApiDocketInvoiceDetails{
  String? invoice_id;
  String? docket_id;
  String? sr_no;
  String? size_id;
  String? packaging_type_id;
  bool? is_volumetric;
  String? length;
  String? breadth;
  String? height;
  String? length_code;
  String? vol_ratio;
  String? cft_volume;
  String? volumatric_weight;
  String? volumatric_weight_code;
  String? actual_weight;
  String? actual_weight_code;
  String? charged_weight;
  String? charged_weight_code;
  String? no_of_package;
  String? item_content_id;
  String? row_rate;
  String? row_rate_id;
  String? row_freight;
  String? length_code_description;
  String? actual_weight_code_description;
  String? charged_weight_code_description;
  String? volumatric_weight_code_description;
  String? row_rate_description;
  String? size;
  String? packaging_type;
  String? item_content;

  ApiDocketInvoiceDetails(
      {this.invoice_id,
       this.docket_id,
       this.sr_no,
       this.size_id,
       this.packaging_type_id,
       this.is_volumetric,
       this.length,
       this.breadth,
       this.height,
       this.length_code,
       this.vol_ratio,
       this.cft_volume,
       this.volumatric_weight,
       this.volumatric_weight_code,
       this.actual_weight,
       this.actual_weight_code,
       this.charged_weight,
       this.charged_weight_code,
       this.no_of_package,
       this.item_content_id,
       this.row_rate,
       this.row_rate_id,
       this.row_freight,
       this.length_code_description,
       this.actual_weight_code_description,
       this.charged_weight_code_description,
       this.volumatric_weight_code_description,
       this.row_rate_description,
       this.size,
       this.packaging_type,
       this.item_content,
      });

  factory ApiDocketInvoiceDetails.fromJson(Map<String, dynamic> json) {
    return ApiDocketInvoiceDetails(
      invoice_id : (json['invoice_id'] ?? '').toString(),
      docket_id : (json['docket_id'] ?? '').toString(),
      sr_no : (json['sr_no'] ?? '').toString(),
      size_id : (json['size_id'] ?? '').toString(),
      packaging_type_id : (json['packaging_type_id'] ?? '').toString(),
      is_volumetric : json['is_volumetric'] ?? false,
      length : (json['length'] ?? '').toString(),
      breadth : (json['breadth'] ?? '').toString(),
      height : (json['height'] ?? '').toString(),
      length_code : (json['length_code'] ?? '').toString(),
      vol_ratio : (json['vol_ratio'] ?? '').toString(),
      cft_volume : (json['cft_volume'] ?? '').toString(),
      volumatric_weight : (json['volumatric_weight'] ?? '').toString(),
      volumatric_weight_code : (json['volumatric_weight_code'] ?? '').toString(),
      actual_weight : (json['actual_weight'] ?? '').toString(),
      actual_weight_code : (json['actual_weight_code'] ?? '').toString(),
      charged_weight : (json['charged_weight'] ?? '').toString(),
      charged_weight_code : (json['charged_weight_code'] ?? '').toString(),
      no_of_package : (json['no_of_package'] ?? '').toString(),
      item_content_id : (json['item_content_id'] ?? '').toString(),
      row_rate : (json['row_rate'] ?? '').toString(),
      row_rate_id : (json['row_rate_id'] ?? '').toString(),
      row_freight : (json['row_freight'] ?? '').toString(),
      length_code_description : (json['length_code_description'] ?? '').toString(),
      actual_weight_code_description : (json['actual_weight_code_description'] ?? '').toString(),
      charged_weight_code_description : (json['charged_weight_code_description'] ?? '').toString(),
      volumatric_weight_code_description : (json['volumatric_weight_code_description'] ?? '').toString(),
      row_rate_description : (json['row_rate_description'] ?? '').toString(),
      size : (json['size'] ?? '').toString(),
      packaging_type : (json['packaging_type'] ?? '').toString(),
      item_content : (json['item_content'] ?? '').toString(),
    );
  }
}

class ApiDocketInvoiceSummary{
  String? invoice_id;
  String? docket_id;
  String? sr_no;
  String? invoice_no;
  String? invoice_date;
  String? invoice_value;
  String? ewb_number;
  String? ewb_date;
  String? ewb_expiry_date;
  String? content_description;
  PartDetails? partDetails;

  ApiDocketInvoiceSummary(
      {this.invoice_id,
       this.docket_id,
       this.sr_no,
       this.invoice_no,
       this.invoice_date,
       this.invoice_value,
       this.ewb_number,
       this.ewb_date,
       this.ewb_expiry_date,
       this.content_description,
       this.partDetails,
      });

  factory ApiDocketInvoiceSummary.fromJson(Map<String, dynamic> json) {
    return ApiDocketInvoiceSummary(
      invoice_id : (json['invoice_id'] ?? '').toString(),
      docket_id : (json['docket_id'] ?? '').toString(),
      sr_no : (json['sr_no'] ?? '').toString(),
      invoice_no : (json['invoice_no'] ?? '').toString(),
      invoice_date : (json['invoice_date'] ?? '').toString(),
      invoice_value : (json['invoice_value'] ?? '').toString(),
      ewb_number : (json['ewb_number'] ?? '').toString(),
      ewb_date : (json['ewb_date'] ?? '').toString(),
      ewb_expiry_date : (json['ewb_expiry_date'] ?? '').toString(),
      content_description : (json['content_description'] ?? '').toString(),
      partDetails: json['part_details'] == null ? null : PartDetails.fromJson(json['part_details']),
    );
  }
}

class PartDetails{
  String? part_id;
  String? invoice_id;
  String? docket_id;
  String? customer_part_id;
  String? part_no ;
  String? part_description;
  String? part_quantity;
  String? part_wise_com_amount;
  String? part_wise_com_amount_collected;
  String? consignor_part_no;
  String? consignee_part_no;
  String? invoice_no;

  PartDetails(
      {this.part_id,
        this.invoice_id,
        this.docket_id,
        this.customer_part_id,
        this.part_no,
        this.part_description,
        this.part_quantity,
        this.part_wise_com_amount,
        this.part_wise_com_amount_collected,
        this.consignor_part_no,
        this.consignee_part_no,
        this.invoice_no,
      });

  factory PartDetails.fromJson(Map<String, dynamic> json) {
    return PartDetails(
      part_id : (json['part_id'] ?? '').toString(),
      invoice_id : (json['invoice_id'] ?? '').toString(),
      docket_id : (json['docket_id'] ?? '').toString(),
      customer_part_id : (json['customer_part_id'] ?? '').toString(),
      part_no : (json['part_no'] ?? '').toString(),
      part_description : (json['part_description'] ?? '').toString(),
      part_quantity : (json['part_quantity'] ?? '').toString(),
      part_wise_com_amount : (json['part_wise_com_amount'] ?? '').toString(),
      part_wise_com_amount_collected : (json['part_wise_com_amount_collected'] ?? '').toString(),
      consignor_part_no : (json['consignor_part_no'] ?? '').toString(),
      consignee_part_no : (json['consignee_part_no'] ?? '').toString(),
      invoice_no : (json['invoice_no'] ?? '').toString(),
    );
  }
}

class ApiDocketEvents{
  String? awbno;
  String? trans_dtm;
  String? docno;
  String? status;
  String? status_code;
  String? event_name;
  String? sr_no;

  ApiDocketEvents(
      {this.awbno,
        this.trans_dtm,
        this.docno,
        this.status,
        this.status_code,
        this.event_name,
        this.sr_no,
      });

  factory ApiDocketEvents.fromJson(Map<String, dynamic> json) {
    return ApiDocketEvents(
      awbno : (json['awbno'] ?? '').toString(),
      trans_dtm : (json['trans_dtm'] ?? '').toString(),
      docno : (json['docno'] ?? '').toString(),
      status : (json['status'] ?? '').toString(),
      status_code : (json['status_code'] ?? '').toString(),
      event_name : (json['event_name'] ?? '').toString(),
      sr_no : (json['sr_no'] ?? '').toString(),
    );
  }
}

class ApiDocketDeliveryAttempts{
  String? awbno;
  bool? is_delivered;
  List<POD>? podList;

  ApiDocketDeliveryAttempts(
      {this.awbno,
        this.is_delivered,
        this.podList,
      });

  factory ApiDocketDeliveryAttempts.fromJson(Map<String, dynamic> json) {
    List d1 = json['Pod'] is List ? json['Pod'] ?? [] : [];
    List<POD> data1 = d1.map((e) => POD.fromJson(e)).toList();
    return ApiDocketDeliveryAttempts(
      awbno : (json['awbno'] ?? '').toString(),
      is_delivered : json['is_delivered'] ?? false,
      podList: data1
    );
  }
}

class POD{
  String? url;

  POD(
      {this.url,
      });

  factory POD.fromJson(Map<String, dynamic> json) {
    return POD(
      url : (json['url'] ?? '').toString(),
    );
  }
}
