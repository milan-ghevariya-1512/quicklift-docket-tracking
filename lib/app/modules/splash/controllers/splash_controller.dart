import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer(const Duration(seconds: 5), () => Get.offAllNamed(Routes.LOGIN));
  }

}