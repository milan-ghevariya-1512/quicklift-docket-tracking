import 'package:get/get.dart';

import '../controllers/internet_check_controller.dart';

class InternetCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternetCheckController>(
      () => InternetCheckController(),
    );
  }
}
