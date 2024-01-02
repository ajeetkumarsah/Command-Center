import 'package:command_centre/helper/global/global.dart' as globals;

Map<String, dynamic> environment = {
  //TODO: Dev
  "fedAuthConfig": {
    'clientID': 'Command Center',
    'clientSecret':
        'QOOthCqZMLOByTFJoPat3U1xXUVVI3unFua54dFWq0d7ShhQ7c9dvPbCyMIhMfvC',
    'redirectURI': 'http://localhost:3000/callback',
    'scope': 'openid email profile pingid',
    'response_type': 'authorization_code'
  },
};

class EnvUtils {
  // TODO: Production

// TODO: Development
  static const String baseURL =
      'https://API-NonProd.pgcloud.com/businessplanningandreporting/otherfinancialdata/v1/IndiaCommandCenter';

// static const String baseURL = 'http://10.0.2.2:3000/';
  static const fedAuthUrl =
      'https://fedauthtst.pg.com/as/authorization.oauth2?client_id=IT%20Command%20Center&response_type=code&scope=openid%20pingid%20email%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback';
  static const callbackVar = 'login';
  static const fedAuthTokenUrl = 'https://fedauthtst.pg.com/as/token.oauth2';
  static const clientID = 'IT Command Center';
  static const redirectURI = 'http://localhost:3000/callback';
  static const clientSecret =
      '6ez2PuphbS3dfYiyHaw0xx0cDvbr7ps7qJfBL1bIrDBSjOmzWpU11xCL6s9z5miI';
  static const subscriptionKey = '8d9c5ffb52eb48be8d9038229975d3db';
}

final Map<String, String> header = {
  'Accept': 'application/json',
  'X_AUTH_TOKEN': globals.authorization,
  'Authorization': "Bearer ${globals.authorization}",
  'Ocp-Apim-Trace': true.toString(),
  'x-access-token': globals.token!,
  'Ocp-Apim-Subscription-Key': EnvUtils.subscriptionKey,
  'Content-Type': 'application/json; charset=UTF-8',
};