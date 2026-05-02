import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quicklift_docket_tracking/app/data/model/getBiddingListModel.dart';
import 'package:quicklift_docket_tracking/app/data/service/bidding_service.dart';
import '../../../../Reusability/utils/storage_util.dart';
import '../../../../Reusability/utils/util.dart';

class BiddingDashboardController extends GetxController {
  //TODO: Implement BiddingDashboardController

  final isLoaded = false.obs;
  final pageNumber = 1.obs;
  DateTime startDate = DateTime.now().subtract(Duration(days: 60));
  DateTime endDate = DateTime.now();
  TextEditingController vrController = TextEditingController();
  VehicleRequestCounts? vehicleRequestCounts;
  List<VehicleRequestsList> vehicleRequestList = [];

  @override
  void onInit() {
    super.onInit();
    getBiddingList(pageNumber: pageNumber.value);
  }

  Future<GetVehicleRequestModel?> fetchBiddingListPage({required int pageNumber, String? statusId}) {
    return BiddingService().getBiddingList(
      vrNo: vrController.text,
      fromDate: DateFormat('yyyy-MM-dd').format(startDate),
      toDate: DateFormat('yyyy-MM-dd').format(endDate),
      customerID: (Utils().box.read(StorageUtil.userId) ?? '').toString(),
      statusId: statusId,
      pageNumber: pageNumber,
      navigateToCheck: true,
    );
  }

  Future<void> getBiddingList({int pageNumber = 1}) async {
    isLoaded.value = true;
    vehicleRequestCounts = null;
    vehicleRequestList.clear();
    final result = await fetchBiddingListPage(
      pageNumber: pageNumber,
      statusId: null,
    );
    isLoaded.value = false;
    if (result != null) {
      vehicleRequestCounts = result.biddingData?.vehicleRequestCounts;
      vehicleRequestList.addAll(result.biddingData?.vehicleRequestList ?? []);
    }
    update();
  }
}
