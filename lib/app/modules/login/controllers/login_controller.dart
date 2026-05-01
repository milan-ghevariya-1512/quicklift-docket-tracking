import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quicklift_docket_tracking/Reusability/utils/util.dart';
import 'package:quicklift_docket_tracking/app/data/service/api_services.dart';
import 'package:quicklift_docket_tracking/app/data/service/api_url_list.dart';

import '../../../../Reusability/utils/storage_util.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {

  TextEditingController noController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled.obs;

  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  var autoValidateMode1 = AutovalidateMode.disabled.obs;

  final fd = FocusNode();
  var isPin = false.obs;

  var secondsRemaining = 60.obs;
  Timer? timer;
  var enableResend = false.obs;

  Future<void> resendCode() async {
    var body = {
      "OrganizationId" : ApiUrlList.organizationId,
      "LoginType": ApiUrlList.loginType,
      "MobileNo": noController.text.trim()
    };
    var result = await DashBoardService().login(body: body);
    if(result != null && result['Success'] == true) {
      secondsRemaining.value = 60;
      enableResend.value = false;
      Utils.toastOk(result['Message']);
    }
    update();
  }


  validate(){
    if(formKey.currentState!.validate()) {
      fd.unfocus();
      login();
    } else {
      autoValidateMode.value = AutovalidateMode.disabled;
    }
    update();
  }

  validate1(context){
    FocusScope.of(context).unfocus();
    if(formKey1.currentState!.validate()) {
      verifyOtp();
    } else {
      autoValidateMode1.value = AutovalidateMode.disabled;
    }
    update();
  }

  @override
  dispose(){
    timer?.cancel();
    super.dispose();
  }

  login() async {
    pinController.text = "";
    Utils.showLoadingDialog();
    var body = {
      "OrganizationId" : ApiUrlList.organizationId,
      "LoginType": ApiUrlList.loginType,
      "MobileNo": noController.text.trim()
    };
    var result = await DashBoardService().login(body: body);
    if(Get.isDialogOpen!) Get.back();
    if(result != null && result['Success'] == true) {
      print('result :: $result');
      Utils.toastOk(result['Message']);
      isPin.value = true;
      pinController.clear();
      secondsRemaining.value = 60;
      Utils().box.remove(StorageUtil.userTypeId);
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        if (secondsRemaining.value != 0) {
          secondsRemaining.value--;
        } else {
          enableResend.value = true;
        }
      });
    }
    update();
  }

  verifyOtp() async {
    Utils.showLoadingDialog();
    var body = {
      "OrganizationId" : ApiUrlList.organizationId,
      "MobileNo": noController.text.trim(),
      "LoginType": ApiUrlList.loginType,
      "OTP": pinController.text
    };
    var result = await DashBoardService().verifyOtp(body: body);
    if(Get.isDialogOpen!) Get.back();
    if(result != null && result['Success'] == true) {
      Utils().setBox("token", result['Data']);
      Utils.toastOk(result['Message']);
      Utils().box.remove(StorageUtil.userTypeId);
      Utils().box.remove(StorageUtil.keyFieldSetup);
      Utils().box.write(StorageUtil.userTypeId, ApiUrlList.loginType);
      Get.offAllNamed(Routes.DASHBOARD);
    }
    update();
  }

}