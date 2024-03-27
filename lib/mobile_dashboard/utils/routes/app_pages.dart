import 'package:get/get.dart';
import '../../views/home_view.dart';
import '../../bindings/home_binding.dart';
import '../../views/login/persona_select_screen.dart';
import '../../views/login/retry_access_denied_screen.dart';
import '../../views/store_fingertips/sales/sales_deep_dive_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/testing.dart';
import 'package:command_centre/mobile_dashboard/views/login/login_screen.dart';
import 'package:command_centre/mobile_dashboard/views/update/update_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/purpose_screen.dart';
import 'package:command_centre/mobile_dashboard/views/splash/splash_screen.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/image_preview.dart';
import 'package:command_centre/mobile_dashboard/views/summary/summary_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/select_geo_screen.dart';
import 'package:command_centre/mobile_dashboard/views/coverage/coverage_screen.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/image_list_preview.dart';
import 'package:command_centre/mobile_dashboard/views/login/access_denied_screen.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/retailing_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/select_profile_screen.dart';
import 'package:command_centre/mobile_dashboard/views/onboarding/onboarding_screen.dart';
import 'package:command_centre/mobile_dashboard/views/maintenance/maintenance_screen.dart';
import 'package:command_centre/mobile_dashboard/views/focus_brand/focus_brand_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/fb/fb_deep_dive.dart';
import 'package:command_centre/mobile_dashboard/views/golden_point/golden_point_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/onboarding_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/gp/gp_deep_dive_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/deepdive_landing_screen.dart';
import 'package:command_centre/mobile_dashboard/views/help_and_support/help_and_support_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/store_fingertips_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/coverage/coverage_deep_dive.dart';
// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const LOGIN = Routes.LOGIN;
  // static const FED_AUTH_LOGIN = Routes.FED_AUTH_LOGIN;
  static const FED_AUTH_LOGIN_TEST = Routes.FED_AUTH_LOGIN_TEST;
  static const RETRY_ACCESS_DENIED = Routes.RETRY_ACCESS_DENIED;
  static const SELECT_PROFILE = Routes.SELECT_PROFILE;
  static const ACCESS_DENIED = Routes.ACCESS_DENIED;
  static const PURPOSE_SCREEN = Routes.PURPOSE_SCREEN;
  static const PERSONA_SCREEN = Routes.PERSONA_SCREEN;
  // static const INTRO_SCREEN = Routes.INTRO_SCREEN;
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
  static const SALES_DEEP_DIVE = Routes.SALES_DEEP_DIVE_SCREEN;
  static const HELP_SUPPORT = Routes.HELP_SUPPORT_SCREEN;
  static const IMAGE_PREVIEW_WIDGET = _Paths.IMAGE_PREVIEW_WIDGET;
  static const IMAGE_PREVIEW_LIST = _Paths.IMAGE_PREVIEW_LIST;
  static const updateScreen = Routes.UPDATE_SCREEN;
  static const maintenanceScreen = Routes.MAINTENANCE_SCREEN;
  static const businessOnboarding = Routes.ONBOARDING_SCREEN;
  //Store@fingertips
  static const sroreFingertipsLanding = Routes.STORE_FINGERTIPS_LANDING;
  static const sroreFingertipsOnboarding = Routes.STORE_FINGERTIPS_ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.FED_AUTH_LOGIN,
    //   page: () => const FedAuthScreen(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.FED_AUTH_LOGIN_TEST,
      page: () => const LoginScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => const BusinessOnboardingScreen(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.INTRO_SCREEN,
    //   page: () => const IntroScreen(),
    //   binding: HomeBinding(),
    // ),
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
      name: _Paths.UPDATE_SCREEN,
      page: () => const UpdateScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAINTENANCE_SCREEN,
      page: () => const MaintenanceScreen(),
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
      name: _Paths.IMAGE_PREVIEW_WIDGET,
      page: () => const ImagePreviewWidget(),
    ),
    GetPage(
      name: _Paths.IMAGE_PREVIEW_LIST,
      page: () => const ImagePreviewList(),
    ),
    GetPage(
      name: _Paths.SUMMARY,
      page: () => const SummaryScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RETAILING_SCREEN,
      page: () => const RetailingScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COVERAGE_SCREEN,
      page: () => const CoverageScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GOLDEN_POINT_SCREEN,
      page: () => const GoldenPointScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FOCUS_BRAND_SCREEN,
      page: () => const FocusBrandScreen(),
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
    GetPage(
      name: _Paths.SALES_DEEP_DIVE,
      page: () => const SalesDeepDiveScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PERSONA_SCREEN,
      page: () => const PersonaScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const SupportAndHelpScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STORE_FINGERTIPS_LANDING,
      page: () => const DeepDiveLandingScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STORE_FINGERTIPS_ONBOARDING,
      page: () => const OnboardingScreen(),
      binding: HomeBinding(),
    ),
  ];
}
