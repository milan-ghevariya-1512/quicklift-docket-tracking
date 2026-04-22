class ApiUrlList {

   static String baseUrl1 = "https://logibrisk.azurewebsites.net/ApiV2/";
   static String baseUrl2 = "https://satpl.erp.logibrisk.com/ApiV2/";
   static String baseUrl3 = "https://quicklift.erp.logibrisk.com/ApiV2/";

   static String url = "https://.erp.logibrisk.com";

   static String commonMasterUrl = '$url/ApiV2/ApiCommonMaster/';

  ///Auth APIs
  static String getOrganizationDetailsApi = '${baseUrl1}ApiAccount/GetOrganizationDetails';
  // static String searchDocketApi = '${baseUrl}ApiDocket/Summary';
  static String searchDocketApi = '${baseUrl2}ApiDocket/DocketDetails';
  static String loginApi = '${baseUrl3}MobileAuthentication/SendMobileOtp';
  static String verifyOtpApi = '${baseUrl3}MobileAuthentication/VerifyMobileOtp';

   static String getFieldSetupApi = '${commonMasterUrl}GetFieldSetup?ModuleCode=';

}