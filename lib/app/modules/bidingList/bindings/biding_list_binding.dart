import 'package:get/get.dart';

import '../controllers/biding_list_controller.dart';

class BidingListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BidingListController>(
      () => BidingListController(),
    );
  }
}
