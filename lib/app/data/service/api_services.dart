import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Reusability/utils/util.dart';
import '../model/get_docket_details_model.dart';
import '../model/get_organization_model.dart';
import '../network/network.dart';
import '../network/networkStander.dart';
import 'api_url_list.dart';

class DashBoardService {

  NetworkHandler networkHandler = NetworkHandler();
  NetworkHandlerStander networkHandlerStander = NetworkHandlerStander();

  Future<List<GetOrganizationModel>?> getOrganization({client}) async {
    client ??= http.Client();

    var url = ApiUrlList.getOrganizationDetailsApi;
    var result = await networkHandlerStander.postWithoutToken(url, client , navigateToCheck: true);

    if(result != null) {
      List data1 = jsonDecode(result);
      List<GetOrganizationModel> organization = data1.map((e) => GetOrganizationModel.fromJson(e)).toList();
      return organization;
    } else {
      return null;
    }
  }

  Future<List<GetDocketDetailsModel>?> searchDocket({client,body,header}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    var url = ApiUrlList.searchDocketApi;
    var result = await networkHandlerStander.post(url, client, token, navigateToCheck: false, model: body);

    if(result != null) {
      List data1 = jsonDecode(result);
      List<GetDocketDetailsModel> details = data1.map((e) => GetDocketDetailsModel.fromJson(e)).toList();
      return details;
    } else {
      return null;
    }
  }

  login({client,body}) async {
    client ??= http.Client();

    var url = ApiUrlList.loginApi;
    var result = await networkHandlerStander.postWithoutToken(url, client,model: body,showError: false);

    if(result != null) {
      return jsonDecode(result);
    } else {
      return null;
    }
  }

  verifyOtp({client,body}) async {
    client ??= http.Client();

    var url = ApiUrlList.verifyOtpApi;
    var result = await networkHandlerStander.postWithoutToken(url, client,model: body,showError: false);

    if(result != null) {
      return jsonDecode(result);
    } else {
      return null;
    }
  }

}