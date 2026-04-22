import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quicklift_docket_tracking/app/data/service/vehicle_service.dart';

import '../../../Reusability/utils/storage_util.dart';
import '../model/fieldSetupModel.dart';

class FieldSetupController extends GetxController {
  final box = GetStorage();

  List<FieldSetupModel> masterField = [];
  final isLoaded = false.obs;
  static const List<String> financeModuleCodes = ['VR'];

  Future<void> getFieldSetup({bool forceRefresh = false}) async {
    isLoaded.value = true;
    if (!forceRefresh) {
      loadFromCache();
      if (masterField.isNotEmpty) {
        final jsonList = masterField.map((e) => e.toJson()).toList();
        log("financeMasterField (from cache) count: ${masterField.length}\n${const JsonEncoder.withIndent('  ').convert(jsonList)}");
        update();
        return;
      }
    } else {
      masterField.clear();
    }

    final list = <FieldSetupModel>[];
    for (final code in financeModuleCodes) {
      final result = await VehicleService().getFieldSetup(
        body: {"ModuleCode": code},
        moduleCode: code,
        navigateToCheck: true,
      );
      if (result?.fieldList != null) list.addAll(result!.fieldList!);
    }

    if (Get.context != null) {
      FocusScope.of(Get.context!).unfocus();
    }
    if (list.isNotEmpty) {
      masterField = list;
      saveToCache(masterField);
    } else if (masterField.isEmpty) {
      isLoaded.value = false;
    }
    update();
  }

  void loadFromCache() {
    try {
      final cached = box.read<String>(StorageUtil.keyFieldSetup);
      if (cached != null && cached.isNotEmpty) {
        final decoded = jsonDecode(cached) as List<dynamic>?;
        if (decoded != null && decoded.isNotEmpty) {
          masterField = decoded
              .map((e) => FieldSetupModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          masterField.clear();
        }
      } else {
        masterField.clear();
      }
    } catch (_) {
      masterField.clear();
    }
  }

  void saveToCache(List<FieldSetupModel> list) {
    try {
      final jsonList = list.map((e) => e.toJson()).toList();
      box.write(StorageUtil.keyFieldSetup, jsonEncode(jsonList));
    } catch (_) {}
  }

  FieldSetupModel? getFieldData(String fieldId) {
    final index = masterField.indexWhere((data) => data.fieldId == fieldId);
    if (index < 0) return null;
    return masterField[index];
  }

  void clearCache() {
    masterField.clear();
    box.remove(StorageUtil.keyFieldSetup);
    isLoaded.value = false;
    update();
  }
}
