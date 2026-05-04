import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Reusability/utils/app_colors.dart';
import 'app/routes/app_pages.dart';

class QuickLiftDocketTracking extends StatefulWidget {
  const QuickLiftDocketTracking({super.key});

  @override
  State<QuickLiftDocketTracking> createState() => _QuickLiftDocketTrackingState();
}

class _QuickLiftDocketTrackingState extends State<QuickLiftDocketTracking> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "QuickLift Tracking",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      routingCallback: (routing) {
        if (routing?.current != Routes.DASHBOARD) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
    );
  }
}
