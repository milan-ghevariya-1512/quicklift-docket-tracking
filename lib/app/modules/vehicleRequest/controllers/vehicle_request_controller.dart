import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quicklift_docket_tracking/app/data/model/getVehicleRequestModel.dart';
import 'package:quicklift_docket_tracking/app/data/service/vehicle_service.dart';

import '../../../data/model/fieldSetupModel.dart';
import '../../../data/model/getAutoCompleteCustomerModel.dart';
import '../../../data/model/getAutoCompleteLocationModel.dart';
import '../../../data/service/field_setup_service.dart';

class VehicleRequestController extends GetxController {
  //TODO: Implement VehicleRequestController

  FieldSetupController get fieldSetup => Get.find<FieldSetupController>();
  var isLoaded = false.obs;

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();

  final List<String> stageTitles = [
    "GENERAL INFO",
    "Leg Details",
    "Bid Details",
    "Vehicle Preference",
    "Load Details"
  ];

  var currentStage = 0.obs;
  VehicleRequestData? vehicleRequestData;

  GetAutoCompleteCustomerModel? selectedCustomer;
  var isCustomerDropdown = true.obs;
  TextEditingController customerController = TextEditingController();
  TextEditingController manualNoController = TextEditingController();
  Rxn<DateTime> requestDateTime = Rxn<DateTime>();
  TextEditingController remarksController = TextEditingController();
  GetAutoCompleteLocationModel? selectedFromLocation;
  GetAutoCompleteLocationModel? selectedToLocation;
  Rxn<DateTime> expLoadingDateTime = Rxn<DateTime>();
  TextEditingController expectedTransitionDaysController = TextEditingController();
  Rxn<DateTime> expDeliveryDateTime = Rxn<DateTime>();
  Rxn<DateTime> vehicleExpReportingDateTime = Rxn<DateTime>();

  var isBiddingRequired = false.obs;
  Rxn<DateTime> biddingStartDateTime = Rxn<DateTime>();
  Rxn<DateTime> biddingEndDateTime = Rxn<DateTime>();
  var isMaxAmount = false.obs;
  TextEditingController maxAmountController = TextEditingController();
  TextEditingController biddingNoteController = TextEditingController();
  var acceptBidFrom = 'AOO'.obs;
  TextEditingController vendorController = TextEditingController();

  TextEditingController noOfVehicleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    requestDateTime.value = DateTime.now();
    expLoadingDateTime.value = DateTime.now();
    vehicleExpReportingDateTime.value = DateTime.now();
    getFieldSetup();
    getVehicleRequest();
  }

  Future<void> getFieldSetup() async {
    isLoaded.value = true;
    await fieldSetup.getFieldSetup();
    isLoaded.value = false;
    update();
  }

  FieldSetupModel? getFieldData(String fieldId) => fieldSetup.getFieldData(fieldId);

  void nextStage() {
    if (currentStage.value == 0) {
      if (!isLoaded.value && formKey1.currentState!.validate()) {
        currentStage.value++;
      }
    } else if (currentStage.value == 1) {
      if (formKey2.currentState!.validate()) {
        currentStage.value++;
      }
    } else if (currentStage.value == 2) {
      if (formKey3.currentState!.validate()) {
        currentStage.value++;
      }
    } else if (currentStage.value == 3) {
      if (formKey4.currentState!.validate()) {
        currentStage.value++;
      }
    }
  }

  void submitOrder(context) {
    if (formKey5.currentState!.validate()) {

    }
  }

  void previousStage() {
    if (currentStage.value > 0) {
      currentStage.value--;
    }
  }

  Future<List<GetAutoCompleteCustomerModel>> getAutoCompleteCustomerList(String term) async {
    var body = {
      "term": term,
    };
    var result = await VehicleService().getAutoCompleteCustomer(body: body, navigateToCheck: false);
    return result ?? [];
  }

  Future<List<GetAutoCompleteLocationModel>> getAutoCompleteLocation(String term) async {
    var body = {
      "term": term,
    };
    var result = await VehicleService().getAutoCompleteLocation(body: body, navigateToCheck: false);
    return result?.locationList ?? [];
  }

  getVehicleRequest() async {
    isLoaded.value = true;
    vehicleRequestData = null;
    var result = await VehicleService().getVehicleRequest(navigateToCheck: true);
    isLoaded.value = false;
    if(result != null) {
      vehicleRequestData = result.vehicleRequestData;
    }
  }
}
