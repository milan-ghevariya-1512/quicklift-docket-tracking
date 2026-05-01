import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quicklift_docket_tracking/app/modules/biddingDashboard/controllers/bidding_dashboard_controller.dart';

import '../../../../Reusability/utils/storage_util.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../data/model/getBiddingListModel.dart';
import '../../../data/service/bidding_service.dart';

class BidingListController extends GetxController {

  var biddingDashboardController = Get.find<BiddingDashboardController>();
  var status = ''.obs;
  var isRequestLoaded = false.obs;
  var isLoadMore = false.obs;
  var noMoreData = false.obs;
  final ScrollController scrollController = ScrollController();
  int page = 1;
  DateTime startDate = DateTime.now().subtract(Duration(days: 60));
  DateTime endDate = DateTime.now();
  TextEditingController vrController = TextEditingController();
  List<VehicleRequestsList> vehicleRequestList = [];

  @override
  void onInit() {
    super.onInit();
    List args = [];
    args = Get.arguments ?? [];
    if(args.isNotEmpty){
      status.value = args.first ?? '';
      getBiddingList();
      scrollController.addListener(() {
        if ((scrollController.position.maxScrollExtent - Get.height*0.012) < scrollController.position.pixels && !noMoreData.value && !isLoadMore.value) {
          page++;
          getBiddingList();
        }
      });
    }
  }

  getBiddingList({bool isPullRefresh = false}) async {
    if(isPullRefresh){
      page = 1;
      isRequestLoaded.value = false;
      noMoreData.value = false;
      isLoadMore.value = false;
    }
    if (!isRequestLoaded.value) {
      isLoadMore.value = true;
      if (page == 1) {
        isRequestLoaded.value = true;
        vehicleRequestList.clear();
      }
      var result = await BiddingService().getBiddingList(
          vrNo: vrController.text,
          fromDate: DateFormat('yyyy-MM-dd').format(startDate),
          toDate: DateFormat('yyyy-MM-dd').format(endDate),
          customerID: (Utils().box.read(StorageUtil.userId) ?? '').toString(),
          statusId: status.value,
          pageNumber: page,
          navigateToCheck: true,
      );
      isRequestLoaded.value = false;
      isLoadMore.value = false;
      if (result != null) {
        if((result.biddingData?.vehicleRequestList ?? []).isEmpty) {
          noMoreData.value = true;
        }
        vehicleRequestList.addAll(result.biddingData?.vehicleRequestList ?? []);
      }
    }
    update();
  }

}
