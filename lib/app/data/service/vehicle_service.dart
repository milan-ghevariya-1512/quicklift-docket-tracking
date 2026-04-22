import 'dart:convert';
import '../../../Reusability/utils/util.dart';
import '../model/fieldSetupModel.dart';
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

}