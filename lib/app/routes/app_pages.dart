import 'package:quicklift_docket_tracking/app/modules/login/bindings/login_binding.dart';
import 'package:quicklift_docket_tracking/app/modules/login/views/login_view.dart';

import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/docket_details/bindings/docket_details_binding.dart';
import '../modules/docket_details/views/docket_details_view.dart';
import '../modules/docket_search/bindings/docket_search_binding.dart';
import '../modules/docket_search/views/docket_search_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/internetCheck/bindings/internet_check_binding.dart';
import '../modules/internetCheck/views/internet_check_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static String INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () =>  SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () =>  DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DOCKETSEARCH,
      page: () =>  DocketSearchView(),
      binding: DocketSearchBinding(),
    ),
    GetPage(
      name: _Paths.DOCKETDETAILS,
      page: () =>  DocketDetailsView(),
      binding: DocketDetailsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.INTERNET_CHECK,
      page: () => InternetCheckView(),
      binding: InternetCheckBinding(),
    ),
  ];
}