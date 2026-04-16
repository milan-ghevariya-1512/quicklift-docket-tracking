import 'package:get/get.dart';
import '../controllers/docket_search_controller.dart';

class DocketSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocketSearchController>(
          () => DocketSearchController(),
    );
  }
}