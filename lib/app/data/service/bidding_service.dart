import 'dart:convert';
import '../../../Reusability/utils/util.dart';
import '../model/getBiddingListModel.dart';
import '../network/network.dart';
import '../network/networkStander.dart';
import 'api_url_list.dart';
import 'package:http/http.dart' as http;

class BiddingService {

  NetworkHandler networkHandler = NetworkHandler();
  NetworkHandlerStander networkHandlerStander = NetworkHandlerStander();

  Future<GetVehicleRequestModel?> getBiddingList({client, vrNo, statusId, fromDate, toDate, customerID, pageNumber, bool navigateToCheck = false}) async {
    client ??= http.Client();
    String token = Utils().getToken() ?? '';

    String url = ApiUrlList.getBiddingListApi;
    List<String> params = [];

    if (vrNo != null && vrNo.toString().isNotEmpty) {
      params.add("VrNo=$vrNo");
    }
    if (fromDate != null && fromDate.toString().isNotEmpty) {
      params.add("FromDate=$fromDate");
    }
    if (toDate != null && toDate.toString().isNotEmpty) {
      params.add("ToDate=$toDate");
    }
    if (customerID != null && customerID.toString().isNotEmpty) {
      params.add("CustomerId=$customerID");
    }
    final statusForQuery = ((statusId ?? '').isNotEmpty && (statusId ?? '') != 'null') ? (statusId ?? '') : null;
    params.add("StatusId=$statusForQuery");
    if (pageNumber != null) {
      params.add("PageNumber=$pageNumber");
    }

    if (params.isNotEmpty) {
      url = "$url?${params.join("&")}";
    }

    var result = await networkHandler.get(url, client, isResponseVersion: true,token, navigateToCheck: navigateToCheck);

    if(result != null) {
      return GetVehicleRequestModel.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

}