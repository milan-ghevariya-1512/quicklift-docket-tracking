import 'package:get/get.dart';

import '../controllers/vehicle_request_controller.dart';

class VehicleRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleRequestController>(
      () => VehicleRequestController(),
    );
  }
}
