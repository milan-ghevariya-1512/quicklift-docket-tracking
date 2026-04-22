import 'dart:convert';
import '../../../Reusability/utils/util.dart';
import '../model/fieldSetupModel.dart';
import '../model/getAutoCompleteCustomerModel.dart';
import '../model/getAutoCompleteLocationModel.dart';
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
    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IkUtVVItMEQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2dyb3Vwc2lkIjoiRSIsImp0aSI6IjU1NzdlMGY2LTBmY2YtNGYxMS05OTQ2LWQ3N2FhZjU5MTRiYiIsImV4cCI6MTc3NjkyOTIxOCwiaXNzIjoiTG9naUJyaXNrIiwiYXVkIjoiTG9naUJyaXNrIn0.Ybwv6-0wQVp3xxWT5xZtQWARgaY9OrDC-yam1byfRkA';

    var url = ApiUrlList.getVehicleRequestApi;
    var result = await networkHandler.get(url, client,token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetVehicleRequestModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }
}