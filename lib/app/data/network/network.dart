import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Reusability/utils/util.dart';
import 'exception.dart';

class NetworkHandler {

  Future<dynamic> post(String url, http.Client client,
      {dynamic model, bool showError = true,headers}) async {
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    // };

    var responseData;
    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: headers, body: model != null ? jsonEncode(model) : null);
      logData(url: url,
          response: response,
          method: "POST",
          model: jsonEncode(model),
          header: headers);
      responseData = returnResponse(
        response,
        url,
        "POST",
        model: model,
        showError: showError,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseData;
  }

  Future<dynamic> get(String url, http.Client client, token, {bool showError = true}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    var responseData;
    try {
      http.Response response =
      await client.get(Uri.parse(url), headers: headers);
      logData(url: url, response: response, method: "GET",header: headers);
      responseData = returnResponse(response, url, "GET",showError: showError);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } finally {}
    return responseData;
  }

  Future<dynamic> put(String url, http.Client client, token,
      {dynamic model, bool showError = true}) async {
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    'Content-Type': 'application/json',
    };

    var responseData;
    try {
      final http.Response response = await client.put(Uri.parse(url),
          headers: headers, body: model != null ? jsonEncode(model) : null);
      logData(url: url,
          response: response,
          method: "PUT",
          model: jsonEncode(model),
          header: headers);
      responseData = returnResponse(
        response,
        url,
        "PUT",
        model: model,
        showError: showError,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseData;
  }

  Future<dynamic> multiPartPost(String url, http.Client client, token,
      {dynamic model, List<http.MultipartFile>? files, bool showError = true}) async {

    var responseData;
    try {

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';

      if(token != null){
        request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      }

      if (model!=null) {
        request.fields.addAll(model);
      }

      if (files != null) {
        request.files.addAll(files);
      }
      var response = await request.send();
      var data = await http.Response.fromStream(response);

      logData(url: url,
          response: data,
          method: "MULTIPART POST",
          model: jsonEncode(model),
          header: request.headers);

      responseData = returnResponse(
        data,
        url,
        "MULTIPART POST",
        model: model,
        showError: showError,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseData;
  }

  Future<dynamic> multiPartPut(String url, http.Client client, token,
      {required model, List<http.MultipartFile>? files, bool showError = true}) async {

    var responseData;
    try {

      var request = http.MultipartRequest('PUT', Uri.parse(url));

      request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';

      request.fields.addAll(model);

      if (files != null) {
        request.files.addAll(files);
      }
      var response = await request.send();
      var data = await http.Response.fromStream(response);

      logData(url: url,
          response: data,
          method: "PUT",
          model: jsonEncode(model),
          header: request.headers);

      responseData = returnResponse(
        data,
        url,
        "MULTIPART PUT",
        model: model,
        showError: showError,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseData;
  }

  Future<dynamic> delete(String url, http.Client client, token,
      {dynamic model, bool showError = true}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };

    var responseData;
    try {
      final http.Response response = await client.delete(Uri.parse(url),
          headers: headers, body: model != null ? jsonEncode(model) : null);
      logData(url: url,
          response: response,
          method: "DELETE",
          model: jsonEncode(model),
          header: headers);
      responseData = returnResponse(
        response,
        url,
        "DELETE",
        model: model,
        showError: showError,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseData;
  }

  Future<dynamic> getWithoutToken(String url, http.Client client, {bool showError = true}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var responseData;
    try {
      final http.Response response =
      await client.get(Uri.parse(url), headers: headers);
      logData(url: url, response: response, method: "GET",header: headers);
      responseData = returnResponse(response, url, "GET", showError: showError);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
    return responseData;
  }

  Future<dynamic> postWithoutToken(String url, http.Client client, {dynamic model,bool showError = true}) async {
    Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var responseData;
    try {
      final http.Response response = await client.post(Uri.parse(url),
          headers: headers, body: jsonEncode(model));
      logData(url: url, response: response, method: "POST WITHOUT TOKEN", model: model,header: headers);
      responseData =
          returnResponse(response, url, "POST WITHOUT TOKEN", model: model, showError: showError);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
    return responseData;
  }

  dynamic returnResponse(http.Response response, url, method, {bool toLogin = true, model, bool showError = true}) async {
    if(Get.isDialogOpen ?? false) {
      Get.back();
    }
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 201:
        var responseJson = response.body;
        return responseJson;
      case 400:
        if(showError)Utils.toastWarning(jsonDecode(response.body)['message'] ?? jsonDecode(response.body)['errors']['msg'] ?? " ");
        return null;
      case 401:
        if(showError)Utils.toastWarning(jsonDecode(response.body)['message'] ?? jsonDecode(response.body)['errors']['msg'] ?? " ");
        return null;
      case 403:
        if(showError)Utils.toastWarning(jsonDecode(response.body)['message'] ?? jsonDecode(response.body)['errors']['msg'] ?? " ");
        var responseJson = response.body;
        return responseJson;
      case 404:
        if(showError)Utils.toastWarning(jsonDecode(response.body)['message'] ?? jsonDecode(response.body)['errors']['msg'] ?? " ");
        return null;
      case 500:
        if(showError)Utils.toastWarning(jsonDecode(response.body)['message'] ?? jsonDecode(response.body)['errors']['msg'] ?? " ");
        return null;
      default:
        if(showError)Utils.toastWarning(jsonDecode(response.body)['message'] ?? jsonDecode(response.body)['errors']['msg'] ?? " ");
        return null;
    }
  }

  logData({required String url, required http.Response response, required String method, model, header, List? files}) {
    log("url: $url");
    log("model: $model");
    log("status code: ${response.statusCode}");
    log("response: ${response.body}");
    log("method: $method");
    log("header: $header");
    if((files ?? []).isNotEmpty)log("files: $files");
  }

}