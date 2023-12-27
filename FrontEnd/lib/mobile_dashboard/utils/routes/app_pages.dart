import 'package:get/get.dart';
import '../../views/home_view.dart';
import '../../bindings/home_binding.dart';
import '../../views/login/retry_access_denied_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/login_screen.dart';
import 'package:command_centre/mobile_dashboard/views/splash/intro_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/purpose_screen.dart';
import 'package:command_centre/mobile_dashboard/views/splash/splash_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/fed_auth_screen.dart';
import 'package:command_centre/mobile_dashboard/views/summary/summary_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/select_geo_screen.dart';
import 'package:command_centre/mobile_dashboard/views/coverage/coverage_screen.dart';
import 'package:command_centre/mobile_dashboard/store_fingertips/fb/fb_deep_dive.dart';
import 'package:command_centre/mobile_dashboard/views/login/access_denied_screen.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/retailing_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/select_profile_screen.dart';
import 'package:command_centre/mobile_dashboard/views/focus_brand/focus_brand_screen.dart';
import 'package:command_centre/mobile_dashboard/views/golden_point/golden_point_screen.dart';
import 'package:command_centre/mobile_dashboard/store_fingertips/gp/gp_deep_dive_screen.dart';
import 'package:command_centre/mobile_dashboard/store_fingertips/store_fingertips_screen.dart';
import 'package:command_centre/mobile_dashboard/store_fingertips/coverage/coverage_deep_dive.dart';
// ignore_for_file: constant_identifier_names



part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const LOGIN = Routes.LOGIN;
  static const FED_AUTH_LOGIN = Routes.FED_AUTH_LOGIN;
  static const RETRY_ACCESS_DENIED = Routes.RETRY_ACCESS_DENIED;
  static const SELECT_PROFILE = Routes.SELECT_PROFILE;
  static const ACCESS_DENIED = Routes.ACCESS_DENIED;
  static const PURPOSE_SCREEN = Routes.PURPOSE_SCREEN;
  static const INTRO_SCREEN = Routes.INTRO_SCREEN;
  static const INITIAL = Routes.HOME;
  static const SUMMARY = Routes.SUMMARY;
  static const RETAILING_SCREEN = Routes.RETAILING_SCREEN;

  static const COVERAGE_SCREEN = Routes.COVERAGE_SCREEN;
  static const GOLDEN_POINT_SCREEN = Routes.GOLDEN_POINT_SCREEN;
  static const FOCUS_BRAND_SCREEN = Routes.FOCUS_BRAND_SCREEN;
  static const SPLASH_SCREEN = Routes.SPLASH_SCREEN;
  static const SELECT_GEO_SCREEN = Routes.SELECT_GEO_SCREEN;
  static const STORE_FINGERTIPS_SCREEN = Routes.STORE_FINGERTIPS_SCREEN;
  static const FB_DEEP_DIVE_SCREEN = Routes.FB_DEEP_DIVE_SCREEN;
  static const GP_DEEP_DIVE_SCREEN = Routes.GP_DEEP_DIVE_SCREEN;
  static const COVERAGE_DEEP_DIVE = Routes.COVERAGE_DEEP_DIVE_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FED_AUTH_LOGIN,
      page: () => const FedAuthScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_SCREEN,
      page: () => const IntroScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_PROFILE,
      page: () => const SelectProfile(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RETRY_ACCESS_DENIED,
      page: () => const RetryAccessDeniedScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ACCESS_DENIED,
      page: () => const AccessDeniedScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PURPOSE_SCREEN,
      page: () => const PurposeScreen(isBool: false),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SUMMARY,
      page: () => const SummaryScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RETAILING_SCREEN,
      page: () => RetailingScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COVERAGE_SCREEN,
      page: () => CoverageScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GOLDEN_POINT_SCREEN,
      page: () => GoldenPointScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FOCUS_BRAND_SCREEN,
      page: () => FocusBrandScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_GEO_SCREEN,
      page: () => const SelectGeoScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STORE_FINGERTIPS_SCREEN,
      page: () => const StoreFingertipsScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FB_DEEP_DIVE,
      page: () => const FBDeepDiveScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GP_DEEP_DIVE,
      page: () => const GPDeepDiveScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COVERAGE_DEEP_DIVE,
      page: () => const CoverageDeepDiveScreen(),
      binding: HomeBinding(),
    ),
  ];
}
