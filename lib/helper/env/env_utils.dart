import 'package:command_centre/helper/global/global.dart' as globals;

Map<String, dynamic> environment1 = {
  //TODO: Dev
  "fedAuthConfig": {
    'clientID': '',
    'clientSecret': '',
    'redirectURI': '',
    'scope': '',
    'response_type': ''
  },
};

class EnvUtils {
  // TODO: Production

// TODO: Development
  static const String baseURL = '';

// static const String baseURL = '';
  static const fedAuthUrl = '';
  static const callbackVar = '';
  static const fedAuthTokenUrl = '';
  static const clientID = '';
  static const redirectURI = '';
  static const clientSecret = '';
  static const subscriptionKey = '';
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
