import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quicklift_docket_tracking/Reusability/utils/util.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteServiceModeModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/getVehicleRequestModel.dart';
import 'package:quicklift_docket_tracking/app/data/service/vehicle_service.dart';

import '../../../../Reusability/utils/storage_util.dart';
import '../../../data/model/fieldSetupModel.dart';
import '../../../data/model/getAutoCompleteCustomerModel.dart';
import '../../../data/model/getAutoCompleteLocationModel.dart';
import '../../../data/model/getAutoCompleteVehicleFtlTypeModel.dart';
import '../../../data/model/getAutoCompleteVehicleModel.dart';
import '../../../data/model/getGeneralMasterModel.dart';
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
  TextEditingController expectedTransitionDaysController = TextEditingController(text: '0.00');
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

  TextEditingController noOfVehicleController = TextEditingController(text: '1');
  GetAutoCompleteVehicleFtlTypeList? selectedVehicleFtlType;
  List<GetAutoCompleteVehicleFtlTypeList> vehicleFtlTypeList = [];
  GetAutoCompleteVehicleModel? selectedVehicleType;
  List<GetAutoCompleteVehicleModel> vehicleTypeList = [];
  ServiceModeList? selectedServiceMode;
  List<ServiceModeList> serviceModeList = [];

  TextEditingController wightController = TextEditingController();
  List<GetGeneralMasterModel> materialTypeList = [];
  GetGeneralMasterModel? selectedMaterialType;
  List<GetGeneralMasterModel> packagingTypeList = [];
  GetGeneralMasterModel? selectedPackagingType;
  TextEditingController driverInstructionController = TextEditingController();

  static const List<String> freightChargeModes = [
    'Flat(In RS)',
    'Per KG',
    'Per TON',
  ];
  TextEditingController freightChargeRateController = TextEditingController();
  TextEditingController freightChargeTotalController = TextEditingController();
  String selectedFreightChargeMode = freightChargeModes.first;
  bool freightChargeSyncing = false;
  late final VoidCallback freightWeightListener;

  @override
  void onInit() {
    super.onInit();
    requestDateTime.value = DateTime.now();
    expLoadingDateTime.value = DateTime.now();
    expDeliveryDateTime.value = DateTime.now();
    vehicleExpReportingDateTime.value = DateTime.now();
    biddingStartDateTime.value = DateTime.now();
    biddingEndDateTime.value = DateTime.now().add(Duration(hours: 2));
    setLocation();
    getFieldSetup();
    getVehicleRequest();
    getAutoCompleteServiceMode();
    getAutoCompleteVehicleFtlType("%");
    getGeneralMaster(masterType: "MAT_TYPE");
    getGeneralMaster(masterType: "PTYPE");
    freightWeightListener = onWeightChangedForFreightCharge;
    wightController.addListener(freightWeightListener);
    freightChargeRateController.addListener(onFreightChargeRateChanged);
    freightChargeTotalController.addListener(onFreightChargeTotalChanged);
  }

  @override
  void onClose() {
    wightController.removeListener(freightWeightListener);
    freightChargeRateController.removeListener(onFreightChargeRateChanged);
    freightChargeTotalController.removeListener(onFreightChargeTotalChanged);
    freightChargeRateController.dispose();
    freightChargeTotalController.dispose();
    super.onClose();
  }

  Future<void> getFieldSetup() async {
    isLoaded.value = true;
    await fieldSetup.getFieldSetup();
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

  Future<void> setLocation() async {
    String currentLocationId = Utils().box.read(StorageUtil.locationId) ?? '';
    var locations = await getAutoCompleteLocation(Utils().box.read(StorageUtil.locationName) ?? '');
    for (var entry in locations) {
      if (entry.codeId == currentLocationId) {
        selectedToLocation = entry;
        selectedFromLocation = entry;
        return;
      }
    }
    update();
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

  getAutoCompleteServiceMode() async {
    isLoaded.value = true;
    serviceModeList.clear();
    selectedServiceMode = null;
    var result = await VehicleService().getAutoCompleteServiceMode(navigateToCheck: false);
    isLoaded.value = false;
    if(result != null && (result.serviceList ?? []).isNotEmpty){
      serviceModeList.addAll(result.serviceList ?? []);
    }
    update();
  }

  getAutoCompleteVehicleFtlType(String term) async {
    isLoaded.value = true;
    vehicleFtlTypeList.clear();
    var body = {
      "term": term,
    };
    var result = await VehicleService().getAutoCompleteVehicleFtlType(body: body, navigateToCheck: false);
    isLoaded.value = false;
    if(result != null && (result.vehicleFtlTypeList ?? []).isNotEmpty){
     vehicleFtlTypeList.addAll(result.vehicleFtlTypeList ?? []);
    }
    update();
  }

  getAutoCompleteVehicleType(String term, String ftlType) async {
    Utils.showLoadingDialog();
    vehicleTypeList.clear();
    var body = {
      "term": term,
      if(ftlType.isNotEmpty)"FtlTypeId": ftlType
    };
    var result = await VehicleService().getAutoCompleteVehicleType(body: body, navigateToCheck: false);
    if(Get.isDialogOpen!)Get.back();
    if(result != null && result.isNotEmpty){
      vehicleTypeList.addAll(result);
    }
    update();
  }

  Future<void> getGeneralMaster({required String masterType}) async {
    isLoaded.value = true;
    if(masterType == 'MAT_TYPE')materialTypeList.clear();
    if(masterType == 'MAT_TYPE')selectedMaterialType = null;
    if(masterType == 'PTYPE')packagingTypeList.clear();
    if(masterType == 'PTYPE')selectedPackagingType = null;
    var body = {
      "MasterType" : masterType
    };
    var result = await VehicleService().getGeneralMaster(body: body);
    isLoaded.value = false;
    FocusScope.of(Get.context!).unfocus();
    if (result != null) {
      if(masterType == 'MAT_TYPE')materialTypeList.addAll(result);
      if(masterType == 'MAT_TYPE' && result.isNotEmpty)selectedMaterialType = result.first;
      if(masterType == 'PTYPE')packagingTypeList.addAll(result);
      if(masterType == 'PTYPE' && result.isNotEmpty)selectedPackagingType = result.first;
    }
    update();
  }

  String formatFreightNumber(double value) {
    return value.toStringAsFixed(2);
  }

  double? parseFreightNumber(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return null;
    return double.tryParse(t);
  }

  double weightInTon() => parseFreightNumber(wightController.text) ?? 0.0;

  void onWeightChangedForFreightCharge() {
    if (freightChargeSyncing) return;
    if (freightChargeRateController.text.trim().isNotEmpty) {
      syncFreightTotalFromRate();
    } else if (freightChargeTotalController.text.trim().isNotEmpty) {
      syncFreightRateFromTotal();
    }
  }

  void onFreightChargeRateChanged() {
    if (freightChargeSyncing) return;
    syncFreightTotalFromRate();
  }

  void onFreightChargeTotalChanged() {
    if (freightChargeSyncing) return;
    syncFreightRateFromTotal();
  }

  void onFreightChargeModeChanged(String? mode) {
    if (mode == null) return;
    selectedFreightChargeMode = mode;
    if (freightChargeRateController.text.trim().isNotEmpty) {
      syncFreightTotalFromRate();
    } else if (freightChargeTotalController.text.trim().isNotEmpty) {
      syncFreightRateFromTotal();
    }
    update();
  }

  void syncFreightTotalFromRate() {
    if (freightChargeSyncing) return;
    if (freightChargeRateController.text.trim().isEmpty) {
      freightChargeSyncing = true;
      try {
        freightChargeTotalController.clear();
      } finally {
        freightChargeSyncing = false;
      }
      return;
    }
    final rate = parseFreightNumber(freightChargeRateController.text);
    if (rate == null) return;
    final wTon = weightInTon();

    freightChargeSyncing = true;
    try {
      switch (selectedFreightChargeMode) {
        case 'Flat(In RS)':
          freightChargeTotalController.text = formatFreightNumber(rate);
          break;
        case 'Per KG':
          final mult = wTon * 1000.0;
          if (mult > 0) {
            freightChargeTotalController.text = formatFreightNumber(rate * mult);
          } else {
            freightChargeTotalController.text = '0.00';
          }
          break;
        case 'Per TON':
          if (wTon > 0) {
            freightChargeTotalController.text = formatFreightNumber(rate * wTon);
          } else {
            freightChargeTotalController.text = '0.00';
          }
          break;
      }
      freightChargeTotalController.selection = TextSelection.collapsed(offset: freightChargeTotalController.text.length);
    } finally {
      freightChargeSyncing = false;
    }
  }

  void syncFreightRateFromTotal() {
    if (freightChargeSyncing) return;
    if (freightChargeTotalController.text.trim().isEmpty) {
      return;
    }
    final total = parseFreightNumber(freightChargeTotalController.text);
    if (total == null) return;
    final wTon = weightInTon();

    freightChargeSyncing = true;
    try {
      switch (selectedFreightChargeMode) {
        case 'Flat(In RS)':
          freightChargeRateController.text = formatFreightNumber(total);
          break;
        case 'Per KG':
          final mult = wTon * 1000.0;
          if (mult > 0) {
            freightChargeRateController.text = formatFreightNumber(total / mult);
          }
          break;
        case 'Per TON':
          if (wTon > 0) {
            freightChargeRateController.text = formatFreightNumber(total / wTon);
          }
          break;
      }
      freightChargeRateController.selection = TextSelection.collapsed(offset: freightChargeRateController.text.length);
    } finally {
      freightChargeSyncing = false;
    }
  }
}
