import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quicklift_docket_tracking/Reusability/utils/util.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteCityModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteLegLocationModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteRateModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/getAutoCompleteServiceModeModel.dart';
import 'package:quicklift_docket_tracking/app/data/model/getVehicleRequestModel.dart';
import 'package:quicklift_docket_tracking/app/data/service/vehicle_service.dart';

import '../../../../Reusability/utils/storage_util.dart';
import '../../../data/model/fieldSetupModel.dart';
import '../../../data/model/getAutoCompleteCustomerModel.dart';
import '../../../data/model/getAutoCompleteLocationModel.dart';
import '../../../data/model/getAutoCompleteVehicleFtlTypeModel.dart';
import '../../../data/model/getAutoCompleteVehicleModel.dart';
import '../../../data/model/getAutoCompleteVendorModel.dart';
import '../../../data/model/getGeneralMasterModel.dart';
import '../../../data/model/legLocationModel.dart';
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

  final GlobalKey<FormFieldState<int>> googleStartLegFormFieldKey = GlobalKey<FormFieldState<int>>();
  final GlobalKey<FormFieldState<int>> googleEndLegFormFieldKey = GlobalKey<FormFieldState<int>>();

  final List<String> stageTitles = ["GENERAL INFO", "Leg Details", "Bid Details", "Vehicle Preference", "Load Details"];

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

  var selectPreferenceType = ''.obs;
  List<TextEditingController> startPointController = [TextEditingController()];
  List<FocusNode> startPointFocusNodes = [FocusNode()];
  List<LegLocationModel> startPointList = [];
  List<TextEditingController> endPointController = [TextEditingController()];
  List<FocusNode> endPointFocusNodes = [FocusNode()];
  List<LegLocationModel> endPointList = [];
  List<LegLocationList?> selectedStartCustomAddress = [null];
  List<LegLocationList?> selectedEndCustomAddress = [null];
  List<LegLocationList> customLocationList = [];
  TextEditingController approxDistanceController = TextEditingController(text: '0.00');
  List<GetAutoCompleteCityModel> cityList = [];
  List<GetAutoCompleteCityModel?> legFromCitySelected = [null];
  List<GetAutoCompleteCityModel?> legToCitySelected = [null];

  var isBiddingRequired = false.obs;
  Rxn<DateTime> biddingStartDateTime = Rxn<DateTime>();
  Rxn<DateTime> biddingEndDateTime = Rxn<DateTime>();
  var isMaxAmount = false.obs;
  TextEditingController maxAmountController = TextEditingController();
  TextEditingController biddingNoteController = TextEditingController();
  var acceptBidFrom = 'AOO'.obs;
  TextEditingController vendorController = TextEditingController();
  List<VendorTypeList> vendorList = [];
  VendorTypeList? selectedVendor;
  List<GetGeneralMasterModel> laneList = [];
  GetGeneralMasterModel? selectedLane;

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
  TextEditingController freightChargeRateController = TextEditingController();
  TextEditingController freightChargeTotalController = TextEditingController();
  List<RateTypeList> rateTypeList = [];
  RateTypeList? selectedRateType;
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
    getAutoCompleteCity("%");
    getAutoCompleteVendor("%");
    getAutoCompleteRateType();
    loadCustomLegAddressOptions();
    getGeneralMaster(masterType: "MAT_TYPE");
    getGeneralMaster(masterType: "PTYPE");
    getGeneralMaster(masterType: "LANE_TYPE");
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
    for (final n in startPointFocusNodes) {
      n.dispose();
    }
    for (final n in endPointFocusNodes) {
      n.dispose();
    }
    for (final t in startPointController) {
      t.dispose();
    }
    for (final t in endPointController) {
      t.dispose();
    }
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
      createVehicleRequest();
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
    isLoaded.value = true;
    selectedToLocation = null;
    selectedFromLocation = null;
    isLoaded.value = false;
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

  Future<void> setCustomer(term, customerId) async {
    isLoaded.value = true;
    selectedCustomer = null;
    var locations = await getAutoCompleteCustomerList(term);
    isLoaded.value = false;
    for (var entry in locations) {
      if (entry.codeId == customerId) {
        selectedCustomer = entry;
        update();
        return;
      }
    }
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
    if (result != null) {
      vehicleRequestData = result.vehicleRequestData;
      if((result.vehicleRequestData?.customerId ?? '').isNotEmpty){
        setCustomer(result.vehicleRequestData?.customerName ?? '%', result.vehicleRequestData?.customerId ?? '');
      } else{
        customerController.text = result.vehicleRequestData?.customerName ?? '';
      }
      if (!(result.vehicleRequestData?.isLegEnable ?? false) && (result.vehicleRequestData?.isCustomerAddress ?? false)) {
        selectPreferenceType.value = 'custom';
      } else if (!(result.vehicleRequestData?.isLegEnable ?? false) && !(result.vehicleRequestData?.isCustomerAddress ?? false)) {
        selectPreferenceType.value = 'google';
      }
    }
    update();
  }

  static bool rowHasResolvedAddress(List<LegLocationModel> legs, int index) {
    if (index < 0 || index >= legs.length) return false;
    final a = legs[index].pointAddress;
    return a != null && a.trim().isNotEmpty;
  }

  String? validateGoogleLegGroup(
      String fieldId,
      List<TextEditingController> controllers,
      List<LegLocationModel> legs,
      ) {
    final config = getFieldData(fieldId);
    if (config == null || !config.isInUse || !config.isRequired) return null;
    for (var i = 0; i < controllers.length; i++) {
      if (!rowHasResolvedAddress(legs, i)) {
        return '    Required';
      }
    }
    return null;
  }

  void scheduleGoogleStartFieldRevalidate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final state = googleStartLegFormFieldKey.currentState;
      if (state == null || !state.mounted) return;
      state.validate();
    });
  }

  void scheduleGoogleEndFieldRevalidate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final state = googleEndLegFormFieldKey.currentState;
      if (state == null || !state.mounted) return;
      state.validate();
    });
  }

  GetAutoCompleteCityModel? matchingCityInOptions(GetAutoCompleteCityModel? selected) {
    if (selected == null) return null;
    for (final o in cityList) {
      if ((o.codeId ?? '').isNotEmpty && (o.codeId ?? '') == (selected.codeId ?? '')) {
        return o;
      }
    }
    for (final o in cityList) {
      if ((o.cityAbrv ?? '') == (selected.cityAbrv ?? '') && (o.codeDesc ?? '') == (selected.codeDesc ?? '')) {
        return o;
      }
    }
    return null;
  }

  void addLegCityRow() {
    legFromCitySelected.add(null);
    legToCitySelected.add(null);
    update();
  }

  void removeLegCityRow(int index) {
    if (legFromCitySelected.length <= 1 || index < 0 || index >= legFromCitySelected.length) {
      return;
    }
    legFromCitySelected.removeAt(index);
    legToCitySelected.removeAt(index);
    update();
  }

  void setLegFromCity(int index, GetAutoCompleteCityModel? value) {
    legFromCitySelected[index] = value;
    update();
  }

  void setLegToCity(int index, GetAutoCompleteCityModel? value) {
    legToCitySelected[index] = value;
    update();
  }

  void renumberLegSequences(List<LegLocationModel> list) {
    for (var i = 0; i < list.length; i++) {
      list[i].pointSequence = (i + 1).toString();
    }
  }

  void upsertStartPointLeg(int index, LegLocationModel leg) {
    while (startPointList.length <= index) {
      startPointList.add(LegLocationModel());
    }
    startPointList[index] = LegLocationModel(
      pointSequence: (index + 1).toString(),
      pointAddress: leg.pointAddress,
      pointAreaName: leg.pointAreaName,
      pointCity: leg.pointCity,
      pointCountry: leg.pointCountry,
      pointPincode: leg.pointPincode,
      pointState: leg.pointState,
    );
    renumberLegSequences(startPointList);
    update();
    scheduleGoogleStartFieldRevalidate();
  }

  void upsertEndPointLeg(int index, LegLocationModel leg) {
    while (endPointList.length <= index) {
      endPointList.add(LegLocationModel());
    }
    endPointList[index] = LegLocationModel(
      pointSequence: (index + 1).toString(),
      pointAddress: leg.pointAddress,
      pointAreaName: leg.pointAreaName,
      pointCity: leg.pointCity,
      pointCountry: leg.pointCountry,
      pointPincode: leg.pointPincode,
      pointState: leg.pointState,
    );
    renumberLegSequences(endPointList);
    update();
    scheduleGoogleEndFieldRevalidate();
  }

  void addStartPointRow() {
    startPointController.add(TextEditingController());
    startPointFocusNodes.add(FocusNode());
    selectedStartCustomAddress.add(null);
    update();
    scheduleGoogleStartFieldRevalidate();
  }

  void removeStartPointRow(int index) {
    if (startPointController.length <= 1 || index < 0 || index >= startPointController.length) {
      return;
    }
    startPointController[index].dispose();
    startPointController.removeAt(index);
    startPointFocusNodes[index].dispose();
    startPointFocusNodes.removeAt(index);
    if (index < startPointList.length) {
      startPointList.removeAt(index);
    }
    if (index < selectedStartCustomAddress.length) {
      selectedStartCustomAddress.removeAt(index);
    }
    renumberLegSequences(startPointList);
    update();
    scheduleGoogleStartFieldRevalidate();
  }

  void addEndPointRow() {
    endPointController.add(TextEditingController());
    endPointFocusNodes.add(FocusNode());
    selectedEndCustomAddress.add(null);
    update();
    scheduleGoogleEndFieldRevalidate();
  }

  void removeEndPointRow(int index) {
    if (endPointController.length <= 1 || index < 0 || index >= endPointController.length) {
      return;
    }
    endPointController[index].dispose();
    endPointController.removeAt(index);
    endPointFocusNodes[index].dispose();
    endPointFocusNodes.removeAt(index);
    if (index < endPointList.length) {
      endPointList.removeAt(index);
    }
    if (index < selectedEndCustomAddress.length) {
      selectedEndCustomAddress.removeAt(index);
    }
    renumberLegSequences(endPointList);
    update();
    scheduleGoogleEndFieldRevalidate();
  }

  LegLocationModel legModelFromAddressItem(LegLocationList item) {
    return LegLocationModel(
      pointAddress: item.address,
      pointAreaName: item.codeDesc,
      pointCity: item.cityName,
      pointCountry: null,
      pointPincode: item.pinCode,
      pointState: null,
    );
  }

  void applyStartCustomLegLocation(int index, LegLocationList? item) {
    while (selectedStartCustomAddress.length <= index) {
      selectedStartCustomAddress.add(null);
    }
    selectedStartCustomAddress[index] = item;
    if (item == null) {
      while (startPointList.length <= index) {
        startPointList.add(LegLocationModel());
      }
      startPointList[index] = LegLocationModel(pointSequence: (index + 1).toString());
      renumberLegSequences(startPointList);
      update();
      scheduleGoogleStartFieldRevalidate();
      return;
    }
    upsertStartPointLeg(index, legModelFromAddressItem(item));
  }

  void applyEndCustomLegLocation(int index, LegLocationList? item) {
    while (selectedEndCustomAddress.length <= index) {
      selectedEndCustomAddress.add(null);
    }
    selectedEndCustomAddress[index] = item;
    if (item == null) {
      while (endPointList.length <= index) {
        endPointList.add(LegLocationModel());
      }
      endPointList[index] = LegLocationModel(pointSequence: (index + 1).toString());
      renumberLegSequences(endPointList);
      update();
      scheduleGoogleEndFieldRevalidate();
      return;
    }
    upsertEndPointLeg(index, legModelFromAddressItem(item));
  }

  Future<List<LegLocationList>> fetchLegAddressOptions(String term) async {
    var body = {
      "term": term,
      "CustomerId": (selectedCustomer?.codeId ?? '').isEmpty ? null : selectedCustomer?.codeId ?? '',
      "OnlyActive": true,
      "WithAllDetails": true,
      "OrganizationId": (Utils().box.read(StorageUtil.organizationId) ?? '').toString(),
    };
    var result = await VehicleService().getAutoCompleteAddress(body: body, navigateToCheck: false);
    return result?.legLocationList ?? [];
  }

  Future<void> loadCustomLegAddressOptions() async {
    final list = await fetchLegAddressOptions('%');
    customLocationList..clear()..addAll(list);
    update();
  }

  LegLocationList? matchingLegLocationInOptions(LegLocationList? selected) {
    if (selected == null) return null;
    for (final o in customLocationList) {
      if ((o.codeId ?? '').isNotEmpty && (o.codeId ?? '') == (selected.codeId ?? '')) {
        return o;
      }
    }
    for (final o in customLocationList) {
      if ((o.address ?? '') == (selected.address ?? '') && (o.codeDesc ?? '') == (selected.codeDesc ?? '')) {
        return o;
      }
    }
    return null;
  }

  getAutoCompleteServiceMode() async {
    isLoaded.value = true;
    serviceModeList.clear();
    selectedServiceMode = null;
    var result = await VehicleService().getAutoCompleteServiceMode(navigateToCheck: false);
    isLoaded.value = false;
    if (result != null && (result.serviceList ?? []).isNotEmpty) {
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
    if (result != null && (result.vehicleFtlTypeList ?? []).isNotEmpty) {
      vehicleFtlTypeList.addAll(result.vehicleFtlTypeList ?? []);
    }
    update();
  }

  getAutoCompleteVehicleType(String term, String ftlType) async {
    Utils.showLoadingDialog();
    vehicleTypeList.clear();
    var body = {"term": term, if (ftlType.isNotEmpty) "FtlTypeId": ftlType};
    var result = await VehicleService().getAutoCompleteVehicleType(body: body, navigateToCheck: false);
    if (Get.isDialogOpen!) Get.back();
    if (result != null && result.isNotEmpty) {
      vehicleTypeList.addAll(result);
    }
    update();
  }

  Future<void> getGeneralMaster({required String masterType}) async {
    isLoaded.value = true;
    if (masterType == 'MAT_TYPE') materialTypeList.clear();
    if (masterType == 'MAT_TYPE') selectedMaterialType = null;
    if (masterType == 'PTYPE') packagingTypeList.clear();
    if (masterType == 'PTYPE') selectedPackagingType = null;
    if (masterType == 'LANE_TYPE') laneList.clear();
    if (masterType == 'LANE_TYPE') selectedLane = null;
    var body = {"MasterType": masterType};
    var result = await VehicleService().getGeneralMaster(body: body);
    isLoaded.value = false;
    FocusScope.of(Get.context!).unfocus();
    if (result != null) {
      if (masterType == 'MAT_TYPE') materialTypeList.addAll(result);
      if (masterType == 'MAT_TYPE' && result.isNotEmpty) selectedMaterialType = result.first;
      if (masterType == 'PTYPE') packagingTypeList.addAll(result);
      if (masterType == 'PTYPE' && result.isNotEmpty) selectedPackagingType = result.first;
      if (masterType == 'LANE_TYPE') laneList.addAll(result);
    }
    update();
  }

  getAutoCompleteCity(String term) async {
    isLoaded.value = true;
    cityList.clear();
    var body = {
      "term": term
    };
    var result = await VehicleService().getAutoCompleteCity(body: body, navigateToCheck: false);
    isLoaded.value = false;
    if (result != null && result.isNotEmpty) {
      cityList.addAll(result);
    }
    update();
  }

  getAutoCompleteVendor(String term) async {
    isLoaded.value = true;
    vendorList.clear();
    selectedVendor = null;
    var body = {
      "term": term,
    };
    var result = await VehicleService().getAutoCompleteVendor(body: body, navigateToCheck: false);
    isLoaded.value = false;
    if (result != null && (result.vendorList ?? []).isNotEmpty) {
      vendorList.addAll(result.vendorList ?? []);
    }
    update();
  }

  getAutoCompleteRateType() async {
    isLoaded.value = true;
    rateTypeList.clear();
    selectedRateType = null;
    var result = await VehicleService().getAutoCompleteRateType(navigateToCheck: false);
    isLoaded.value = false;
    if (result != null && (result.rateList ?? []).isNotEmpty) {
      rateTypeList.addAll(result.rateList ?? []);
      if((result.rateList ?? []).isNotEmpty)selectedRateType = (result.rateList ?? []).first;
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

  void onFreightChargeModeChanged(RateTypeList? mode) {
    if (mode == null) return;
    selectedRateType = mode;
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
      switch (selectedRateType?.codeId) {
        case 'R1':
          freightChargeTotalController.text = formatFreightNumber(rate);
          break;
        case 'R6':
          final mult = wTon * 1000.0;
          if (mult > 0) {
            freightChargeTotalController.text = formatFreightNumber(rate * mult);
          } else {
            freightChargeTotalController.text = '0.00';
          }
          break;
        case 'R5':
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
      switch (selectedRateType?.codeId) {
        case 'R1':
          freightChargeRateController.text = formatFreightNumber(total);
          break;
        case 'R6':
          final mult = wTon * 1000.0;
          if (mult > 0) {
            freightChargeRateController.text = formatFreightNumber(total / mult);
          }
          break;
        case 'R5':
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

  List<Map<String, dynamic>>? buildLegsPayload() {
    if (!(vehicleRequestData?.isLegEnable ?? false)) return null;
    final legsPayload = <Map<String, dynamic>>[];
    for (var i = 0; i < legFromCitySelected.length; i++) {
      final from = legFromCitySelected[i];
      final to = legToCitySelected[i];
      if (from == null || to == null) continue;
      final fromId = (from.cityAbrv ?? '').trim().isNotEmpty ? from.cityAbrv!.trim() : (from.codeId ?? '').trim();
      final toId = (to.cityAbrv ?? '').trim().isNotEmpty ? to.cityAbrv!.trim() : (to.codeId ?? '').trim();
      legsPayload.add({
        "LegNumber": i + 1,
        "FromCityId": fromId.isEmpty ? null : fromId,
        "FromPlace": (from.codeDesc ?? '').trim().isEmpty ? null : (from.codeDesc ?? '').trim(),
        "ToCityId": toId.isEmpty ? null : toId,
        "ToPlace": (to.codeDesc ?? '').trim().isEmpty ? null : (to.codeDesc ?? '').trim(),
      });
    }
    return legsPayload.isEmpty ? null : legsPayload;
  }

  createVehicleRequest() async {
    Utils.showLoadingDialog();
    List pickupPoints = [];
    List deliveryPoints = [];
    if(!(vehicleRequestData?.isLegEnable ?? false) && selectPreferenceType.value == 'google'){
      for(int i=0; i < startPointList.length; i++){
        pickupPoints.add({
          "PointSequence" : i + 1,
          "PointAddress" : (startPointList[i].pointAddress ?? '').isEmpty ? null : startPointList[i].pointAddress ?? '',
          "PointCity" : (startPointList[i].pointCity ?? '').isEmpty ? null : startPointList[i].pointCity ?? '',
          "PointState" : (startPointList[i].pointState ?? '').isEmpty ? null : startPointList[i].pointState ?? '',
          "PointCountry" : (startPointList[i].pointCountry ?? '').isEmpty ? null : startPointList[i].pointCountry ?? '',
          "PointPincode" : (startPointList[i].pointPincode ?? '').isEmpty ? null : startPointList[i].pointPincode ?? '',
          "PointAreaName" : (startPointList[i].pointAreaName ?? '').isEmpty ? null : startPointList[i].pointAreaName ?? '',
        });
      }
      for(int j=0; j < startPointList.length; j++){
        deliveryPoints.add({
          "PointSequence" : j + 1,
          "PointAddress" : (endPointList[j].pointAddress ?? '').isEmpty ? null : endPointList[j].pointAddress ?? '',
          "PointCity" : (endPointList[j].pointCity ?? '').isEmpty ? null : endPointList[j].pointCity ?? '',
          "PointState" : (endPointList[j].pointState ?? '').isEmpty ? null : endPointList[j].pointState ?? '',
          "PointCountry" : (endPointList[j].pointCountry ?? '').isEmpty ? null : endPointList[j].pointCountry ?? '',
          "PointPincode" : (endPointList[j].pointPincode ?? '').isEmpty ? null : endPointList[j].pointPincode ?? '',
          "PointAreaName" : (endPointList[j].pointAreaName ?? '').isEmpty ? null : endPointList[j].pointAreaName ?? '',
        });
      }
    } else if(!(vehicleRequestData?.isLegEnable ?? false) && selectPreferenceType.value == 'custom'){
      for(int p=0; p < selectedStartCustomAddress.length; p++){
        pickupPoints.add({
          "PointSequence" : p + 1,
          "PointAddress" : (selectedStartCustomAddress[p]?.address ?? '').isEmpty ? null : selectedStartCustomAddress[p]?.address ?? '',
          "PointCity" : (selectedStartCustomAddress[p]?.cityName ?? '').isEmpty ? null : selectedStartCustomAddress[p]?.cityName ?? '',
          "PointState" : null,
          "PointCountry" : null,
          "PointPincode" : (selectedStartCustomAddress[p]?.pinCode ?? '').isEmpty ? null : selectedStartCustomAddress[p]?.pinCode ?? '',
          "PointAreaName" : null,
        });
      }
      for(int q=0; q < selectedEndCustomAddress.length; q++){
        deliveryPoints.add({
          "PointSequence" : q + 1,
          "PointAddress" : (selectedEndCustomAddress[q]?.address ?? '').isEmpty ? null : selectedEndCustomAddress[q]?.address ?? '',
          "PointCity" : (selectedEndCustomAddress[q]?.cityName ?? '').isEmpty ? null : selectedEndCustomAddress[q]?.cityName ?? '',
          "PointState" : null,
          "PointCountry" : null,
          "PointPincode" : (selectedEndCustomAddress[q]?.pinCode ?? '').isEmpty ? null : selectedEndCustomAddress[q]?.pinCode ?? '',
          "PointAreaName" : null,
        });
      }
    }
    var body = {
      "YearId": (Utils().box.read(StorageUtil.yearId) ?? '').toString(),
      "CurrencyId": (Utils().box.read(StorageUtil.currencyId) ?? '').toString(),
      "CompanyId": (Utils().box.read(StorageUtil.companyId) ?? '').toString(),
      "GenerationLocationId": (Utils().box.read(StorageUtil.locationId) ?? '').toString(),
      "ManualNo": manualNoController.text.isEmpty ? null : manualNoController.text,
      "RequestDate": requestDateTime.value,
      "Remarks": remarksController.text.isEmpty ? null : remarksController.text,
      "CustomerId": ((selectedCustomer?.codeId ?? '').isEmpty && selectedCustomer == null) ? null : selectedCustomer?.codeId ?? '',
      "CustomerName": ((selectedCustomer?.codeId ?? '').isEmpty && selectedCustomer == null) ? customerController.text.isEmpty ? null : customerController.text : selectedCustomer?.codeDesc ?? '',
      "CustomerCode": ((selectedCustomer?.codeId ?? '').isEmpty && selectedCustomer == null) ? null : selectedCustomer?.customerCode ?? '',
      "MaterialTypeId": (selectedMaterialType?.codeId ?? '').isEmpty ? null : selectedMaterialType?.codeId ?? '',
      "PackagingTypeId": (selectedPackagingType?.codeId ?? '').isEmpty ? null : selectedPackagingType?.codeId ?? '',
      "PreferenceTypeId": null,
      "FromAddressId": null,
      "ToAddressId": null,
      "FromLocationId": (selectedFromLocation?.codeId ?? '').isEmpty ? null : selectedFromLocation?.codeId ?? '',
      "ToLocationId": (selectedToLocation?.codeId ?? '').isEmpty ? null : selectedToLocation?.codeId ?? '',
      "ApproxDistance": approxDistanceController.text.isEmpty ? 0 : approxDistanceController.text,
      "ExpLoadingDate": expLoadingDateTime.value,
      "ExpectedTransitionDays": expectedTransitionDaysController.text.isEmpty ? 0 : expectedTransitionDaysController.text,
      "ExpDeliveryTime": expDeliveryDateTime.value,
      "VehicleReportingTime": vehicleExpReportingDateTime.value,
      "InstructionForDriver": driverInstructionController.text.isEmpty ? null : driverInstructionController.text,
      "IsBiddingRequired": isBiddingRequired.value,
      "BidStartDate": biddingStartDateTime.value,
      "BidEndDate": biddingEndDateTime.value,
      "IsCapRate": isMaxAmount.value,
      "MaximumRate": maxAmountController.text.isEmpty ? 0 : maxAmountController.text,
      "BiddingNote": biddingNoteController.text.isEmpty ? null : biddingNoteController.text,
      "AcceptBidFrom": acceptBidFrom.value,
      "LaneType": null, //["LOCAL", "NATIONAL"],
      "VendorId": ["E-V-Z", "E-V-0P","E-V-08","E-V-18","E-V-0F","E-V-1G","E-V-07"],
      "ServiceModeId": (selectedServiceMode?.codeId ?? '').isEmpty ? null : selectedServiceMode?.codeId ?? '',
      "FtlTypeId": (selectedVehicleFtlType?.codeId ?? '').isEmpty ? null : selectedVehicleFtlType?.codeId ?? '',
      "VehicleTypeId": (selectedVehicleType?.codeId ?? '').isEmpty ? null : selectedVehicleType?.codeId ?? '',
      "RequiredNoOfVehicle": noOfVehicleController.text.isEmpty ? 0 : noOfVehicleController.text,
      "Weight": wightController.text.isEmpty ? 0 : wightController.text,
      "RateAmount": freightChargeRateController.text.isEmpty ? 0 : freightChargeRateController.text,
      "RateTypeId": selectedRateType == null ? null : selectedRateType,
      "FreightCharge": freightChargeTotalController.text.isEmpty ? 0 : freightChargeTotalController.text,
      "PickupPoints": pickupPoints.isEmpty ? null : pickupPoints,
      "DeliveryPoints": deliveryPoints.isEmpty ? null : deliveryPoints,
      "Legs": buildLegsPayload(),
    };
    var result = await VehicleService().createVehicleRequest(body: body, navigateToCheck: false);
    if (Get.isDialogOpen!) Get.back();
    if (result != null) {

    }
    update();
  }
}
