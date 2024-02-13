class AppConstants {
  static const int APP_VERSION = 1;
  // static const BASE_URL =
  //     'https//cmndcntr-web-dev-web01.azurewebsites.net/'; //public/appData
  static const String BASE_URL =
      'https://API-NonProd.pgcloud.com/businessplanningandreporting/otherfinancialdata/v1/IndiaCommandCenter/';
  static const String FED_AUTH_URL =
      'https://fedauthtst.pg.com/as/authorization.oauth2?client_id=IT%20Command%20Center&response_type=code&grant_type=refresh&scope=openid%20pingid%20email%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback';

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
