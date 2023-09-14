import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import '../../helper/global/global.dart' as globals;

import '../../helper/app_urls.dart';
import '../../helper/env/env_utils.dart';
import '../../helper/env/jwt_decoder.dart';
import '../../helper/global/global.dart';
import '../../utils/sharedpreferences/sharedpreferences_utils.dart';

class LoginController {
  var logger = Logger();

  Future<bool> getAccessTokenFromCode(code)async {
    try {
      logger.v("Get a token");
      var response = await http.post(
          Uri.parse(
            // Todo: For Dev
              "${URL.FedAuthBaseUrl}/${URL.FedAuthGetTokenEndpoint}"
          ),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          // Todo: For Dev
          body: {
            "code": code,
            'client_id': '${environment['fedAuthConfig']['clientID']}',
            'client_secret': '${environment['fedAuthConfig']['clientSecret']}',
            'grant_type': 'authorization_code',
            'redirect_uri': '${environment['fedAuthConfig']['redirectURI']}',
          }
      );
      // logger.v('Authorization Code inside access token function: ${pingCode}');

      if (response.statusCode == 200) {

        var mapResponse = json.decode(response.body);
        // logger.v('Authorization Request Response: ${mapResponse}');
        logger.v('access_token: ${mapResponse['access_token']}');
        logger.v('id_token: ${mapResponse['id_token']}');
        logger.v('expires_in: ${mapResponse['expires_in']}');

        SharedPreferencesUtils.setString("access_token", mapResponse['access_token']);
        var accessToken = SharedPreferencesUtils.getString("access_token")!;
        // globals.pingCode = SharedPreferencesUtils.getString("pingCode")!;
        // logger.v('access_token global: $access_token');
        // logger.v('pingCode global: $pingCode');

        isLoggedIn = await getUserInfo(accessToken);

        return isLoggedIn;
      } else {
        logger.v(json.decode(response.body));
        logger.v("getAccessTokenFromCode error code = ${response.statusCode}");
        return false;
      }
    } catch (e) {
      logger.e('Inside catch: $e');
      return false;
    }
  }

  Future<bool> getUserInfo(accessToken) async {
      logger.v("Using Access Token to get UserInfo");
     try{
       ///To check whether the token is valid or not
       if(JwtDecoder.tryDecode(accessToken) != null && !(JwtDecoder.isExpired(accessToken))){
         var mappedUserInfo = JwtDecoder.decode(accessToken);
         logger.v('UserInfo Response: $mappedUserInfo');

         SharedPreferencesUtils.setString("id", mappedUserInfo['Uid']);
         SharedPreferencesUtils.setString("email", mappedUserInfo['Mail']);
         SharedPreferencesUtils.setString("fullName", mappedUserInfo['FullName']);
         SharedPreferencesUtils.setString("userName", mappedUserInfo['Username']);
         SharedPreferencesUtils.setBool("isLoggedIn", true);

         //set globals
         globals.id = SharedPreferencesUtils.getString("id") ?? '';
         globals.email = SharedPreferencesUtils.getString("email") ?? '';
         globals.fullName = SharedPreferencesUtils.getString("fullName") ?? '';
         globals.userName = SharedPreferencesUtils.getString("userName") ?? '';
         globals.isLoggedIn = SharedPreferencesUtils.getBool("isLoggedIn") ?? false;

         // FirebaseAnalytics.instance.logEvent(name: "${globals.id}", parameters: {
         //   'id':globals.id,
         //   'email':globals.email,
         //   'fullName': globals.fullName,
         //   'userName': globals.userName,
         // });

         logger.v('id: ${SharedPreferencesUtils.getString("id")}');
         logger.v('email: ${SharedPreferencesUtils.getString("email")}');
         logger.v('fullName: ${SharedPreferencesUtils.getString("fullName")}');
         logger.v('userName: ${SharedPreferencesUtils.getString("userName")}');

         return isLoggedIn;

       } else {
         logger.v("getUserInfo Access Token Error");
         return false;
       }
     }catch(error){
       print('Jwt error: $error');
       return false;
     }
  }

  Future<bool> logout(accessToken) async{
    try{
    var response = await http.post(
      Uri.parse('${URL.FedAuthBaseUrl}/${URL.FedAuthRevokeTokenEndpoint}'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        "token": accessToken,
      }
    );
    // logger.d(response);
    if (response.statusCode == 200) {
      logger.d('inside logout function with statusCode: ${response.statusCode}');
      SharedPreferencesUtils.remove('pingCode');
      SharedPreferencesUtils.remove('access_token');
      SharedPreferencesUtils.remove('id_token');
      SharedPreferencesUtils.remove('expires_in');
      SharedPreferencesUtils.remove('id');
      SharedPreferencesUtils.remove('email');
      SharedPreferencesUtils.remove('fullName');
      SharedPreferencesUtils.remove('userName');
      SharedPreferencesUtils.remove('isLoggedIn');
      SharedPreferencesUtils.remove('holdSaveStatusVendorValue');
      SharedPreferencesUtils.remove('holdSaveStatusRollValue');
      SharedPreferencesUtils.remove('holdSaveStatusEvidenceValue');
      SharedPreferencesUtils.remove('holdSaveStatusFormValue');
      return true;
    }
    else{
      logger.d('inside logout function with statusCode: ${response.statusCode}');
      return false;
    }
    }
    catch(e){
      logger.e('inside logout catch block error: $e');
      return false;
    }
  }

}