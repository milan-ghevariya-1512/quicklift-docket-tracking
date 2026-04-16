import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Reusability/utils/app_colors.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    title: "QuickLift Tracking",
    debugShowCheckedModeBanner: false,
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    color: AppColors.primaryColor,
    theme: ThemeData(
      primaryColor: AppColors.primaryColor,
      colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
      buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
    ),
  ));
}