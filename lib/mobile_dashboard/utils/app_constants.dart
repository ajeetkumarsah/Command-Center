class AppConstants {
  static const String APP_VERSION = '1.0.6';
  // static const BASE_URL =
  //     'https//cmndcntr-web-dev-web01.azurewebsites.net/'; //public/appData
  static const String BASE_URL =
      'https://API-NonProd.pgcloud.com/businessplanningandreporting/otherfinancialdata/v1/IndiaCommandCenter/';
  static const String FED_AUTH_URL =
      'https://fedauthtst.pg.com/as/authorization.oauth2?client_id=IT%20Command%20Center&response_type=code&scope=openid%20pingid%20email%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback';

  static const String FED_AUTH_TOKEN =
      'https://fedauthtst.pg.com/as/token.oauth2';
  static const CLIENT_ID = 'IT Command Center';
  static const REDIRECT_URI = 'http://localhost:3000/callback';
  static const CLIENT_SECRET =
      '6ez2PuphbS3dfYiyHaw0xx0cDvbr7ps7qJfBL1bIrDBSjOmzWpU11xCL6s9z5miI';
  static const SUBSCRIPTION_KEY = '8d9c5ffb52eb48be8d9038229975d3db';
  static const SUMMARY = 'appData';
  static const RETAILING_DATA = 'appData/mtdRetailingTable';
  static const COVERAGE_DATA = 'appData/coverageTable';
  static const GP_DATA = 'appData/dgpComplianceTable';
  static const FOCUS_BRAND_DATA = 'appData/focusBrand';
  static const FILTERS = 'appData/branchlist';
  static const CHANNELLIST = 'appData/channellist';
  static const PERSONASELECT = 'appData/storeList';
  static const STORE_DATA = 'appData/focusBrandTable';
  static const CONFIG = 'appData/inventory';

  //sharedPreferences
  static const String USER_ID = 'userId';
  static const String RETAILING = 'retailing';
  static const String COVERAGE = 'coverage';
  static const String GOLDEN_POINTS = 'goldenPoints';
  static const String FOCUS_BRAND = 'focusBrand';
  static const String TOKEN = 'token';
  static const String EMAIL = 'email';
  static const String NAME = 'name';
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
