import 'dart:convert';
import '../../../Reusability/utils/util.dart';
import '../model/fieldSetupModel.dart';
import '../model/getAutoCompleteCustomerModel.dart';
import '../model/getAutoCompleteLegLocationModel.dart';
import '../model/getAutoCompleteLocationModel.dart';
import '../model/getAutoCompleteServiceModeModel.dart';
import '../model/getAutoCompleteVehicleFtlTypeModel.dart';
import '../model/getAutoCompleteVehicleModel.dart';
import '../model/getGeneralMasterModel.dart';
import '../model/getLoginClaimModel.dart';
import '../model/getVehicleRequestModel.dart';
import '../network/network.dart';
import '../network/networkStander.dart';
import 'api_url_list.dart';
import 'package:http/http.dart' as http;

class VehicleService {

  NetworkHandler networkHandler = NetworkHandler();
  NetworkHandlerStander networkHandlerStander = NetworkHandlerStander();

  Future<GetFieldListModel?> getFieldSetup({client, body, moduleCode, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = "${ApiUrlList.getFieldSetupApi}$moduleCode";
    var result = await networkHandler.post(url, client, model: body, isResponseVersion: true,token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetFieldListModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<List<GetAutoCompleteCustomerModel>?> getAutoCompleteCustomer({client, body, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.getAutoCompleteCustomerApi;
    var result = await networkHandlerStander.post(url, client, model: body, token, navigateToCheck: navigateToCheck);

    if(result != null) {
      List data1 = jsonDecode(result);
      List<GetAutoCompleteCustomerModel> customerList = data1.map((e) => GetAutoCompleteCustomerModel.fromJson(e)).toList();
      return customerList;
    } else {
      return null;
    }
  }

  Future<GetAutoCompleteLegLocationModel?> getAutoCompleteAddress({client, body, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.getAutoCompleteAddressApi;
    var result = await networkHandlerStander.post(url, client, model: body, token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetAutoCompleteLegLocationModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<GetLocationModel?> getAutoCompleteLocation({client, body, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.getAutoCompleteLocationApi;
    var result = await networkHandler.post(url, client, model: body, isResponseVersion: true,token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetLocationModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<GetVehicleRequestModel?> getVehicleRequest({client, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IkUtVVItMEQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2dyb3Vwc2lkIjoiRSIsImp0aSI6ImI1N2MyYTc5LTEzMzMtNGUzZi1hODlmLWJlYjNlNmQxYWY2YyIsImV4cCI6MTc3NzAyNDU3MSwiaXNzIjoiTG9naUJyaXNrIiwiYXVkIjoiTG9naUJyaXNrIn0.NNum5YheQq_U5HjgMvKeeUvFD0sYQUqAvo_FAsm-v6E';

    var url = ApiUrlList.getVehicleRequestApi;
    var result = await networkHandler.get(url, client,token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetVehicleRequestModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<GetServiceModeModel?> getAutoCompleteServiceMode({client, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.getAutoCompleteServiceModeApi;
    var result = await networkHandler.get(url, client, isResponseVersion: true, token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetServiceModeModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<GetVehicleFtlTypeModel?> getAutoCompleteVehicleFtlType({client, body, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.getAutoCompleteVehicleFtlTypeApi;
    var result = await networkHandler.post(url, client, isResponseVersion: true,model: body, token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetVehicleFtlTypeModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<List<GetAutoCompleteVehicleModel>?> getAutoCompleteVehicleType({client, body, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.getAutoCompleteVehicleTypeApi;
    var result = await networkHandlerStander.post(url, client, model: body, token, navigateToCheck: navigateToCheck);

    if(result != null) {
      List data1 = jsonDecode(result);
      List<GetAutoCompleteVehicleModel> customerList = data1.map((e) => GetAutoCompleteVehicleModel.fromJson(e)).toList();
      return customerList;
    } else {
      return null;
    }
  }

  Future<List<GetGeneralMasterModel>?> getGeneralMaster({client, body, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.getGeneralMasterApi;
    var result = await networkHandlerStander.multiPartPost(url, model: body,client, isResponseVersion: true,token, navigateToCheck: navigateToCheck);

    if(result != null) {
      List data1 = jsonDecode(result);
      List<GetGeneralMasterModel> generalList = data1.map((e) => GetGeneralMasterModel.fromJson(e)).toList();
      return generalList;
    } else {
      return null;
    }
  }

  Future<GetLoginClaimModel?> getClaims({client, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IkUtVVItMEQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2dyb3Vwc2lkIjoiRSIsImp0aSI6ImI1N2MyYTc5LTEzMzMtNGUzZi1hODlmLWJlYjNlNmQxYWY2YyIsImV4cCI6MTc3NzAyNDU3MSwiaXNzIjoiTG9naUJyaXNrIiwiYXVkIjoiTG9naUJyaXNrIn0.NNum5YheQq_U5HjgMvKeeUvFD0sYQUqAvo_FAsm-v6E';

    var url = ApiUrlList.getClaimsApi;
    var result = await networkHandlerStander.post(url, client, token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetLoginClaimModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  createVehicleRequest({client, body, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.createVehicleRequestApi;
    var result = await networkHandlerStander.post(url, model: body,client,token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return jsonDecode(result);
    } else {
      return null;
    }
  }
}