import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as Http;
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/error_model.dart';
// ignore_for_file: library_prefixes, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

class MultipartBody {
  String key;
  PickedFile file;

  MultipartBody(this.key, this.file);
}

class ApiClient extends GetxService {
  final String appBaseUrl = AppConstants.BASE_URL;

  final SharedPreferences sharedPreferences;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    _mainHeaders = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  // Future<Response> getLocation(String text) async {
  //   var client = Http.Client();
  //   try {
  //     debugPrint(
  //         'Final URL==>${Uri.parse(AppConstants.BASE_URL + AppConstants.SEARCH_LOCATION_URI + text)}');
  //     Http.Response _response = await client
  //         .get(
  //           Uri.parse(AppConstants.BASE_URL +
  //               AppConstants.SEARCH_LOCATION_URI +
  //               text),
  //         )
  //         .timeout(const Duration(seconds: 30));
  //     Response response = handleResponse(_response);
  //     debugPrint('API Response===> Return Success ');
  //     return response;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return Response(statusCode: 1, statusText: e.toString());
  //   }
  // }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        headers['Authorization'] =
            'Bearer ${sharedPreferences.getString(AppConstants.TOKEN)}';
        debugPrint(
            '===>TOKEN:${sharedPreferences.getString(AppConstants.TOKEN)}');
        headers['Content-Type'] = 'application/json';
      }
      _mainHeaders = {'Content-Type': 'application/json'};
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getData(String uri,
      {Map<String, String>? headers, bool withBaseUrl = false}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (headers != null) {
      headers['Authorization'] =
          'Bearer ${sharedPreferences.getString(AppConstants.ACCESS_TOKEN)}';
      // debugPrint('Token: ${sharedPreferences.getString(AppConstants.TOKEN)}');
    }
    try {
      Http.Response _response = await Http.get(
        withBaseUrl ? Uri.parse(uri) : Uri.parse(appBaseUrl + uri),
        headers: headers ?? {},
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getWithParamsData(String uri, String baseUrl,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (headers != null) {
      headers['Authorization'] =
          'Bearer ${sharedPreferences.getString(AppConstants.TOKEN)}';
      headers['Content-Type'] = 'application/json';
    }
    try {
      Http.Response _response = await Http.get(
        Uri.https(baseUrl, uri, queryParameters),
        headers: headers ?? {},
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers, bool isRefresh = false}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    if (headers != null) {
      debugPrint(
          '===>TOKEN:${sharedPreferences.getString(AppConstants.ACCESS_TOKEN)}');
      headers['Authorization'] =
          'Bearer ${sharedPreferences.getString(AppConstants.ACCESS_TOKEN)}';
      headers['Content-Type'] = 'application/json';
      headers['Accept'] = '*/*';
      headers['X_AUTH_TOKEN'] =
          sharedPreferences.getString(AppConstants.ACCESS_TOKEN) ?? '';
      headers['x-access-token'] =
          sharedPreferences.getString(AppConstants.TOKEN) ?? '';
      headers['Ocp-Apim-Trace'] = true.toString();
      headers['Ocp-Apim-Subscription-Key'] = AppConstants.SUBSCRIPTION_KEY;
    }

    _mainHeaders = {'Content-Type': 'application/json'};
    try {
      debugPrint('==>Final URL: ${Uri.parse(appBaseUrl + uri)}');
      debugPrint('==>Body : ${jsonEncode(body)}');

      Logger().log(Level.info, '==>Header: ${headers ?? _mainHeaders}');
      debugPrint('==>Header: ${headers ?? _mainHeaders}');
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 60));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (headers != null) {
      headers['Authorization'] =
          'Bearer ${sharedPreferences.getString(AppConstants.TOKEN)}';
      debugPrint(
          '===>TOKEN:${sharedPreferences.getString(AppConstants.TOKEN)}');
      headers['Content-Type'] = 'application/json';
    }
    _mainHeaders = {'Content-Type': 'application/json'};
    try {
      debugPrint('==>Final URL: ${Uri.parse(appBaseUrl + uri)}');
      debugPrint('==>Body : ${jsonEncode(body)}');
      debugPrint('==>Header: $_mainHeaders');
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        body: body != null ? jsonEncode(body) : null,
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> patchData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (headers != null) {
      headers['Authorization'] =
          'Bearer ${sharedPreferences.getString(AppConstants.TOKEN)}';
      debugPrint(
          '===>TOKEN:${sharedPreferences.getString(AppConstants.TOKEN)}');
      headers['Content-Type'] = 'application/json';
    }
    _mainHeaders = {'Content-Type': 'application/json'};
    try {
      debugPrint('==>Final URL: ${Uri.parse(appBaseUrl + uri)}');
      debugPrint('==>Body : ${jsonEncode(body)}');
      debugPrint('==>Header: $_mainHeaders');
      Http.Response _response = await Http.patch(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(const Duration(seconds: 30));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> API Call: $uri\nToken: $token');
        debugPrint('====> API Body: $body');
      }
      if (headers != null) {
        debugPrint(
            '===>TOKEN:${sharedPreferences.getString(AppConstants.ACCESS_TOKEN)}');
        headers['Authorization'] =
        'Bearer ${sharedPreferences.getString(AppConstants.ACCESS_TOKEN)}';
        headers['Content-Type'] = 'application/json';
        headers['Accept'] = '*/*';
        headers['X_AUTH_TOKEN'] =
            sharedPreferences.getString(AppConstants.ACCESS_TOKEN) ?? '';
        headers['x-access-token'] =
            sharedPreferences.getString(AppConstants.TOKEN) ?? '';
        headers['Ocp-Apim-Trace'] = true.toString();
        headers['Ocp-Apim-Subscription-Key'] = AppConstants.SUBSCRIPTION_KEY;
      }

      _mainHeaders = {'Content-Type': 'application/json'};
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders!);
      for (MultipartBody multipart in multipartBody) {
        // ignore: unnecessary_null_comparison
        if (multipart.file != null) {
          if (Foundation.kIsWeb) {
            Uint8List _list = await multipart.file.readAsBytes();
            Http.MultipartFile _part = Http.MultipartFile(
              multipart.key,
              multipart.file.readAsBytes().asStream(),
              _list.length,
              filename: basename(multipart.file.path),
              contentType:
                  MediaType('image', multipart.file.path.split('.').last),
            );
            _request.files.add(_part);
          } else {
            File _file = File(multipart.file.path);
            _request.files.add(
              Http.MultipartFile(
                multipart.key,
                _file.readAsBytes().asStream(),
                _file.lengthSync(),
                filename: _file.path.split('/').last,
              ),
            );
          }
        }
      }
      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint('Exception ===>$e');
    }
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        debugPrint('==>from if');
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{success')) {
        debugPrint('==>from else if');
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      } else if (_response.body.toString().startsWith('{status')) {
        debugPrint('==>from status');
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = const Response(
          statusCode: 0,
          statusText:
              'Connection to API server failed due to internet connection');
    }
    return _response;
  }
}
