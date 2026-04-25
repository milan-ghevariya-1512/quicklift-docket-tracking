class ApiUrlList {

   static String baseUrl1 = "https://logibrisk.azurewebsites.net/ApiV2/";
   static String baseUrl2 = "https://satpl.erp.logibrisk.com/ApiV2/";
   static String baseUrl3 = "https://express.erp.logibrisk.com/ApiV2/";

   static String url = "https://express.erp.logibrisk.com";
   static String googleMapKey = "AIzaSyC-SC-VSkuluh_1JkVwtmc5v1YMm6nSeVo";
   static String loginType = "AFK"; // Customer:AFK, Employee:AFJ, Vendor:AFL
   static String organizationId = "E"; // 1

   static String commonMasterUrl = '$url/ApiV2/ApiCommonMaster/';
   static String vehicleRequestUrl = '$url/apiv2/ApiVehicleRequest/';
   static String accountUrl = '$url/ApiV2/ApiAccount/';

  ///Auth APIs
  static String getOrganizationDetailsApi = '${baseUrl1}ApiAccount/GetOrganizationDetails';
  // static String searchDocketApi = '${baseUrl}ApiDocket/Summary';
  static String searchDocketApi = '${baseUrl2}ApiDocket/DocketDetails';
  static String loginApi = '${baseUrl3}MobileAuthentication/SendMobileOtp';
  static String verifyOtpApi = '${baseUrl3}MobileAuthentication/VerifyMobileOtp';

   static String getFieldSetupApi = '${commonMasterUrl}GetFieldSetup?ModuleCode=';
   static String getAutoCompleteCustomerApi = '${commonMasterUrl}AutoCompleteCustomer';
   static String getAutoCompleteAddressApi = '${vehicleRequestUrl}AutoCompleteAddress';
   static String getAutoCompleteLocationApi = '${commonMasterUrl}AutoCompleteLocation';
   static String getVehicleRequestApi = '${vehicleRequestUrl}Get';
   static String getAutoCompleteVehicleFtlTypeApi = '${commonMasterUrl}AutoCompleteVehicleFtlType';
   static String getAutoCompleteVehicleTypeApi = '${commonMasterUrl}AutoCompleteVehicleType';
   static String getAutoCompleteServiceModeApi = '${vehicleRequestUrl}AutoCompleteServiceMode';
   static String getGeneralMasterApi = '${commonMasterUrl}GetGeneralMaster';
   static String getClaimsApi = '${accountUrl}GetClaims';
   static String getAutoCompleteCityApi = '${commonMasterUrl}AutoCompleteCity';
   static String getAutoCompleteVendorApi = '${commonMasterUrl}AutoCompleteVendor';
   static String getAutoCompleteRateTypeApi = '${vehicleRequestUrl}AutoCompleteRateType';
   static String createVehicleRequestApi = '${vehicleRequestUrl}Create';

}