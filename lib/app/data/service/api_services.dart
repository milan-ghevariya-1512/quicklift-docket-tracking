import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/get_docket_details_model.dart';
import '../model/get_organization_model.dart';
import '../network/network.dart';
import 'api_url_list.dart';

class DashBoardService {

  NetworkHandler networkHandler = NetworkHandler();

  Future<List<GetOrganizationModel>?> getOrganization({client,header}) async {
    client ??= http.Client();

    var url = ApiUrlList.getOrganizationDetailsApi;
    var result = await networkHandler.post(url, client,headers: header);

    if(result != null) {
      List data1 = jsonDecode(result);
      List<GetOrganizationModel> organization = data1.map((e) => GetOrganizationModel.fromJson(e)).toList();
      return organization;
    } else {
      return null;
    }
  }

  // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEtNzM1OTk3OTY0NyIsImp0aSI6IjI4NGMxNDI0LTEzOWEtNDhkYi1iZDkwLWNhNzc4MDQ5YWYwYiIsIk9yZ2FuaXphdGlvbklkIjoiMSIsIkNvbXBhbnlJZCI6IjEtMDEiLCJVc2VySWQiOiIxLVUtMyIsIlVzZXJOYW1lIjoiNzM1OTk3OTY0NyIsIk1vYmlsZU5vIjoiNzM1OTk3OTY0NyIsIkN1cnJlbnRGaW5hbmNpYWxZZWFyIjoiMS1GLTEiLCJUaW1lWm9uZUlkIjoiNTQiLCJUaW1lWm9uZURpc3BsYXlOYW1lIjoiQXNpYS9Lb2xrYXRhIiwiQXV0aGVudGljYXRpb25UeXBlIjoiQjRKIiwiZXhwIjoxNzMzNTY5ODg3LCJpc3MiOiJMb2dpQnJpc2siLCJhdWQiOiJMb2dpQnJpc2sifQ.phaAkzdy2p88Uf1VJ5BDOarfxoDApCbhIu6oyIKJnx4

  Future<List<GetDocketDetailsModel>?> searchDocket({client,body,header}) async {
    client ??= http.Client();

    var url = ApiUrlList.searchDocketApi;
    var result = await networkHandler.post(url, client,headers: header,model: body);

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
    var result = await networkHandler.postWithoutToken(url, client,model: body,showError: false);

    if(result != null) {
      return jsonDecode(result);
    } else {
      return null;
    }
  }

  verifyOtp({client,body}) async {
    client ??= http.Client();

    var url = ApiUrlList.verifyOtpApi;
    var result = await networkHandler.postWithoutToken(url, client,model: body,showError: false);

    if(result != null) {
      return jsonDecode(result);
    } else {
      return null;
    }
  }

}