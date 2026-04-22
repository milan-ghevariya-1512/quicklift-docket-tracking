import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Reusability/utils/storage_util.dart';
import '../../../Reusability/utils/util.dart';
import 'exception.dart';

class NetworkHandlerStander {

  Future<dynamic> post(String url, http.Client client, token, {dynamic model, bool isResponseVersion = false,bool showError = true, bool navigateToCheck = false}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var version = Utils().box.read(StorageUtil.appVersion);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
        if(isResponseVersion)'ResponseVersion': "2.0",
        'AppVersion': version
      };

      var responseData;
      try {
        final http.Response response = await http.post(Uri.parse(url),
            headers: headers, body: model != null ? jsonEncode(model) : null);
        logApiCall(
          url: url,
          response: response,
          method: 'POST',
          header: headers.toString(),
          requestPayload: model != null ? jsonEncode(model) : null,
        );
        responseData = returnResponse(
          response,
          url,
          "POST",
          model: model,
          showError: showError,
        );
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      }
      return responseData;
    }
  }

  Future<dynamic> get(String url, http.Client client, token, {bool showError = true, bool isResponseVersion = false, bool navigateToCheck = false}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var version = Utils().box.read(StorageUtil.appVersion);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
        if(isResponseVersion)'ResponseVersion': "2.0",
        'AppVersion': version
      };
      var responseData;
      try {
        http.Response response =
        await client.get(Uri.parse(url), headers: headers);
        logApiCall(url: url, response: response, header: headers.toString(),method: 'GET');
        responseData = returnResponse(response, url, "GET",showError: showError);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      } finally {}
      return responseData;
    }
  }

  Future<dynamic> put(String url, http.Client client, token, {dynamic model, bool showError = true, bool navigateToCheck = false}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var version = Utils().box.read(StorageUtil.appVersion);
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
        'AppVersion': version
      };

      var responseData;
      try {
        final http.Response response = await client.put(Uri.parse(url),
            headers: headers, body: model != null ? jsonEncode(model) : null);
        logApiCall(
          url: url,
          response: response,
          method: 'PUT',
          header: headers.toString(),
          requestPayload: model != null ? jsonEncode(model) : null,
        );
        responseData = returnResponse(
          response,
          url,
          "PUT",
          model: model,
          showError: showError,
        );
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      }
      return responseData;
    }
  }

  Future<dynamic> multiPartPost(String url, http.Client client, token, {bool isResponseVersion = false, dynamic model, List<http.MultipartFile>? files, bool showError = true, bool navigateToCheck = false}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var responseData;

      try {
        var version = Utils().box.read(StorageUtil.appVersion);
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
        request.headers['AppVersion'] = version;
        if(isResponseVersion)request.headers['ResponseVersion'] = '2.0';
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

        logApiCall(
          url: url,
          header: request.headers.toString(),
          response: data,
          method: 'MULTIPART POST',
          requestPayload: model != null ? jsonEncode(model) : null,
        );

        responseData = returnResponse(
          data,
          url,
          "MULTIPART POST",
          model: model,
          showError: showError,
        );
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      }
      return responseData;
    }
  }

  Future<dynamic> multiPartPut(String url, http.Client client, token, {required model, List<http.MultipartFile>? files, bool showError = true, bool navigateToCheck = false}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var responseData;
      try {
        var version = Utils().box.read(StorageUtil.appVersion);
        var request = http.MultipartRequest('PUT', Uri.parse(url));

        request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
        request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
        request.headers['AppVersion'] = version;
        request.fields.addAll(model);

        if (files != null) {
          request.files.addAll(files);
        }
        var response = await request.send();
        var data = await http.Response.fromStream(response);

        logApiCall(
          url: url,
          response: data,
          method: 'MULTIPART PUT',
          header: request.headers.toString(),
          requestPayload: model != null ? jsonEncode(model) : null,
        );

        responseData = returnResponse(
          data,
          url,
          "MULTIPART PUT",
          model: model,
          showError: showError,
        );
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      }
      return responseData;
    }
  }

  Future<dynamic> delete(String url, http.Client client, token, {dynamic model, bool showError = true, bool navigateToCheck = false}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var version = Utils().box.read(StorageUtil.appVersion);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
        'AppVersion': version
      };
      var responseData;
      try {
        final http.Response response = await client.delete(Uri.parse(url),
            headers: headers, body: model != null ? jsonEncode(model) : null);
        logApiCall(
          url: url,
          response: response,
          method: 'DELETE',
          header: headers.toString(),
          requestPayload: model != null ? jsonEncode(model) : null,
        );
        responseData = returnResponse(
          response,
          url,
          "DELETE",
          model: model,
          showError: showError,
        );
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      }
      return responseData;
    }
  }

  Future<dynamic> getWithoutToken(String url, http.Client client, {bool showError = true, bool navigateToCheck = false, String? loggingUserId}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var version = Utils().box.read(StorageUtil.appVersion);
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'AppVersion': version
      };
      var responseData;
      try {
        final http.Response response =
        await client.get(Uri.parse(url), headers: headers);
        logApiCall(url: url, response: response, header: headers.toString(),method: 'GET');
        responseData = returnResponse(response, url, "GET", showError: showError);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      }
      return responseData;
    }
  }

  Future<dynamic> postWithoutToken(String url, http.Client client, {dynamic model,bool showError = true, bool navigateToCheck = false, String? loggingUserId}) async {
    bool isConnected = await Utils().hasInternetConnection(navigateToCheck: navigateToCheck);
    if (isConnected) {
      var version = Utils().box.read(StorageUtil.appVersion);
      Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8','AppVersion': version};
      var responseData;
      try {
        final http.Response response = await client.post(Uri.parse(url),
            headers: headers, body: jsonEncode(model));
        logApiCall(
          url: url,
          response: response,
          header: headers.toString(),
          method: 'POST WITHOUT TOKEN',
          requestPayload: model != null ? jsonEncode(model) : null,
        );
        responseData =
            returnResponse(response, url, "POST WITHOUT TOKEN", model: model, showError: showError);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      } on Exception catch (e) {
        throw FetchDataException(e.toString());
      }
      return responseData;
    }
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
        if(showError)Utils.toastError(jsonDecode(response.body) ?? "");
        return null;
      case 401:
        if(showError)Utils.toastError(jsonDecode(response.body) ?? "");
        return null;
      case 403:
        if(showError)Utils.toastError(jsonDecode(response.body) ?? "");
        var responseJson = response.body;
        return responseJson;
      case 404:
        if(showError)Utils.toastError(jsonDecode(response.body) ?? "");
        return null;
      case 405:
        if(showError)Utils.toastError(jsonDecode(response.body) ?? "");
        var responseJson = response.body;
        return responseJson;
      case 500:
        if(showError)Utils.toastError(jsonDecode(response.body) ?? "");
        return null;
      default:
        if(showError)Utils.toastError(jsonDecode(response.body) ?? "");
        return null;
    }
  }

  void logApiCall({
    required String url,
    required http.Response response,
    required String method,
    required String header,
    String? requestPayload,
    String? userId,
  }) {
    log("url: $url");
    log("header: $header");
    log("model: $requestPayload");
    log("status code: ${response.statusCode}");
    log("response: ${response.body}");
    log("method: $method");
  }

  void logoutUser() {
    Utils().isLogin();
    Utils.toastWarning("Session Expired! Please Login Again..".tr);
  }

}