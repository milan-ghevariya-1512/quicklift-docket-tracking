import 'package:get/get.dart';

import '../controllers/bidding_dashboard_controller.dart';

class BiddingDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiddingDashboardController>(
      () => BiddingDashboardController(),
    );
  }
}
