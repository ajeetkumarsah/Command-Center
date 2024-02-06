import 'package:command_centre/mobile_dashboard/utils/sec_helper/env.dart';
import 'package:command_centre/mobile_dashboard/utils/sec_helper/obfuscation.dart';

class AppConstants {
  static const int APP_VERSION = 1;
  static String BASE_URL =
                  Obfuscation.decodeString(environment['fedAuthConst']['baseUrl']);
  static String FED_AUTH_URL =
           Obfuscation.decodeString(environment['fedAuthConst']['fedAuth']);

  static String FED_AUTH_TOKEN =
                    Obfuscation.decodeString(environment['fedAuthConst']['fedToken']);
  static String CLIENT_ID = Obfuscation.decodeString(environment['fedAuthConfig']['clientID']);
  static String REDIRECT_URI = Obfuscation.decodeString(environment['fedAuthConfig']['redirectURI']);
  static String CLIENT_SECRET =
                 Obfuscation.decodeString(environment['fedAuthConfig']['clientSecret']);
  static String SUBSCRIPTION_KEY = Obfuscation.decodeString(environment['fedAuthConfig']['subscription_key']);

  static const SUMMARY = 'appData';
  static const RETAILING_DATA = 'appData/mtdRetailingTable';
  static const COVERAGE_DATA = 'appData/coverageTable';
  static const GP_DATA = 'appData/dgpComplianceTable';
  static const FOCUS_BRAND_DATA = 'appData/focusBrand';
  static const FILTERS = 'appData/branchlist';
  static const STORE_DATA = 'appData/focusBrandTable';

  //sharedPreferences
  static const String USER_ID = 'userId';
  static const String RETAILING = 'retailing';
  static const String COVERAGE = 'coverage';
  static const String GOLDEN_POINTS = 'goldenPoints';
  static const String FOCUS_BRAND = 'focusBrand';
  static const String TOKEN = 'token';
  static const String EMAIL = 'email';
  static const String NAME = 'name';
  static const String PING_CODE = 'pingCode';
  static const String SEEN = 'seen';
  static const String ACCESS_TOKEN = 'accessToken';
  static const String USER_NAME = 'userName';
  static const String USER_IMAGE = 'userImage';
  static const String DEFAULT_GEO = 'defaultGeo';
  static const String DEFAULT_GEO_VALUE = 'defaultGeoValue';
  static const String USER_PURPOSE = 'userPurpose';
  static const String YEAR = 'year';
  static const String MONTH = 'month';
  static const String PERSONLIZED_ACTIVE = 'prsonalizedAvcitve';
  static const String PERSONLIZED_MORE = 'prsonalizedMore';
  static const String PERSONA = 'persona';

  //
  static const String STORE = 'store';
  static const String FB_TARGET = 'fbTarget';
  static const String FB_ACHIEVED = 'fbAchieved';
}
