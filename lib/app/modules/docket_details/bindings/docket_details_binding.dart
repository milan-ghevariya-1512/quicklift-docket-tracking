import 'package:get/get.dart';
import '../controllers/docket_details_controller.dart';

class DocketDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocketDetailsController>(
          () => DocketDetailsController(),
    );
  }
}