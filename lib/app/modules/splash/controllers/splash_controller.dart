import 'dart:async';
import 'package:get/get.dart';
import '../../../../Reusability/utils/storage_util.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPackageInfo();
    Timer(const Duration(seconds: 5), () => Get.offAllNamed(Routes.LOGIN));
  }

  Future<void> getPackageInfo() async {
    // final packageInfo = await Utils.getPackageInfo();
    Utils().box.write(StorageUtil.appVersion, '1.0.0');
    // Utils().box.write(StorageUtil.appVersion, packageInfo.version.toString());
  }

}