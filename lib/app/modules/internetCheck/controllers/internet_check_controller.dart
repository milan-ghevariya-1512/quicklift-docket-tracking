import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../../Reusability/utils/util.dart';
import '../../../routes/app_pages.dart';

class InternetCheckController extends GetxController {
  var isConnected = false.obs;
  var isLoading = true.obs;
  var connectionType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
    Connectivity().onConnectivityChanged.listen((result) {
      checkInternetConnection();
    });
  }

  Future<void> checkInternetConnection() async {
    isLoading.value = true;
    try {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        isConnected.value = true;
        connectionType.value = 'Mobile Data';
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        isConnected.value = true;
        connectionType.value = 'Wi-Fi';
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        isConnected.value = true;
        connectionType.value = 'Ethernet';
      } else {
        isConnected.value = false;
        connectionType.value = 'No Connection';
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Utils.toastWarning("No internet connection");
      }
    } catch (e) {
      isConnected.value = false;
      connectionType.value = 'Error';
      Utils.toastError("Error checking connection");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onContinueTap() async {
    if (isConnected.value) {
      Get.offAllNamed(AppPages.INITIAL);
    }
  }
}
