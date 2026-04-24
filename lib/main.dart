import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quicklift_docket_tracking/app.dart';
import 'app/data/service/field_setup_service.dart';

void main() async {
  await GetStorage.init();
  Get.put(FieldSetupController(), permanent: true);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(QuickLiftDocketTracking());
}