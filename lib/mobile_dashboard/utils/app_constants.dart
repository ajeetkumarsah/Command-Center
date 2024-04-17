import 'package:command_centre/mobile_dashboard/utils/sec_helper/obfuscation.dart';
// ignore_for_file: non_constant_identifier_names

// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_VERSION = '1.0.6';

  static String BASE_URL = Obfuscation.decodeString(
      '68747470733a2f2f6170692e7067636c6f75642e636f6d2f627573696e657373706c616e6e696e67616e647265706f7274696e672f6f7468657266696e616e6369616c646174612f76312f496e646961436f6d6d616e6443656e7465722f');

  static String FED_AUTH_URL =

  Obfuscation.decodeString('68747470733a2f2f666564617574682e70672e636f6d2f61732f617574686f72697a6174696f6e2e6f61757468323f636c69656e745f69643d436f6d6d616e6425323043656e74657226726573706f6e73655f747970653d636f64652673636f70653d6f70656e696425323070726f66696c652672656469726563745f7572693d687474702533412532462532466c6f63616c686f73742533413330303025324663616c6c6261636b2670666964706164617074657269643d4f617574682672656d656d62657243686f6963653d7472756526726573706f6e73655f6d6f64653d7175657279');

  static String FED_AUTH_TOKEN = Obfuscation.decodeString(
      '68747470733a2f2f666564617574682e70672e636f6d2f61732f746f6b656e2e6f6175746832');

  static String CLIENT_ID =
      Obfuscation.decodeString('436f6d6d616e642043656e746572');

  static String REDIRECT_URI = Obfuscation.decodeString(
      '687474703a2f2f6c6f63616c686f73743a333030302f63616c6c6261636b');

  static String CLIENT_SECRET = Obfuscation.decodeString(
      '683771595a4c4464395476557a565171756c586f56456c54346c524d626f6745626d446a6a507072464d524677306b46644b31583777384f4e7a487236755071');

  static String SUBSCRIPTION_KEY = Obfuscation.decodeString(
      '3563373039643335353164363436646538343230636530313765666261636332');

  static const SUMMARY = 'appData';
  static const RETAILING_DATA = 'appData/mtdRetailingTable';
  static const COVERAGE_DATA = 'appData/coverageTable';
  static const GP_DATA = 'appData/dgpComplianceTable';
  static const FOCUS_BRAND_DATA = 'appData/focusBrand';
  static const FILTERS = 'appData/branchlist';
  static const FIREBASE_VAR_UPDATE = 'appData/firebase/autoRefresh';
  static const CHANNELLIST = 'appData/channellist';
  static const PERSONASELECT = 'appData/storeList';
  static const STORE_DATA = 'appData/focusBrandTable';
  static const CONFIG = 'appData/inventory';
  static const EMPLOYEE_AUTH = 'appData/employeeAuthentication';

  //sharedPreferences
  static const String USER_ID = 'userId';
  static const String RETAILING = 'retailing';
  static const String COVERAGE = 'coverage';
  static const String GOLDEN_POINTS = 'goldenPoints';
  static const String FOCUS_BRAND = 'focusBrand';
  static const String TOKEN = 'token';
  static const String EMAIL = 'email';
  static const String NAME = 'name';
  static const String USER_GUIDE = 'userGuide';
  static const String UID = 'uid';
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
  static const String FCMToken = 'FCMToken';

  //
  static const String STORE = 'store';
  static const String FB_TARGET = 'fbTarget';
  static const String FB_ACHIEVED = 'fbAchieved';

  // local storage keys :)
  static const String RETAILING_GEO = 'retailing-geo';
  static const String RETAILING_CATEGORY = 'retailing-category';
  static const String RETAILING_CHANNEL = 'retailing-channel';
  static const String RETAILING_TRENDS = 'retailing-trends';
  //coverage
  static const String COVERAGE_GEO = 'coverage-geo';
  static const String COVERAGE_CATEGORY = 'coverage-category';
  static const String COVERAGE_CHANNEL = 'coverage-channel';
  static const String COVERAGE_TRENDS = 'coverage-trends';
  //gp
  static const String GP_GEO = 'gp-geo';
  static const String GP_CATEGORY = 'gp-category';
  static const String GP_CHANNEL = 'gp-channel';
  static const String GP_TRENDS = 'gp-trends';
  //fb
  static const String FB_GEO = 'fb-geo';
  static const String FB_CATEGORY = 'fb-category';
  static const String FB_CHANNEL = 'fb-channel';
  static const String FB_TRENDS = 'fb-trends';
}


 // static const String BASE_URL =
  //     'https://API-NonProd.pgcloud.com/businessplanningandreporting/otherfinancialdata/v1/IndiaCommandCenter/';
  // static const String FED_AUTH_URL =
  //     'https://fedauthtst.pg.com/as/authorization.oauth2?client_id=IT%20Command%20Center&response_type=code&scope=openid%20pingid%20email%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback&pfidpadapterid=ad..OAuth&rememberChoice=true&response_mode=query';

  // static const String FED_AUTH_TOKEN =
  //     'https://fedauthtst.pg.com/as/token.oauth2';

  // static const CLIENT_ID = 'IT Command Center';
  // static const REDIRECT_URI = 'http://localhost:3000/callback';
  // static const CLIENT_SECRET =
  //     '6ez2PuphbS3dfYiyHaw0xx0cDvbr7ps7qJfBL1bIrDBSjOmzWpU11xCL6s9z5miI';
  // static const SUBSCRIPTION_KEY = '8d9c5ffb52eb48be8d9038229975d3db';