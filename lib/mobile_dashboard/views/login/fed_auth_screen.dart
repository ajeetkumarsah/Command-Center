import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/login/access_denied_screen.dart';

class FedAuthScreen extends StatefulWidget {
  const FedAuthScreen({super.key});

  @override
  State<FedAuthScreen> createState() => _FedAuthScreenState();
}

class _FedAuthScreenState extends State<FedAuthScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late final WebViewController _controller1;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: false,
  ));

  @override
  void initState() {
    super.initState();
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            logger.v('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            logger.v('Page started loading: $url');
          },
          onPageFinished: (String url) {
            logger.v('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            logger.v('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
                ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("http://localhost:3000/callback?code=")) {
              var uri = Uri.dataFromString(request.url);
              var code = uri.queryParameters['code'];

              getUserProfileFromCode(code);
              return NavigationDecision.prevent;
            } else if (request.url.contains('access_denied')) {
              Get.offAndToNamed(AppPages.RETRY_ACCESS_DENIED);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const RetryAccessDenied()));
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(AppConstants.FED_AUTH_URL));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller1 = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Command Center',
          style: GoogleFonts.ptSans(color: AppColors.black),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Builder(builder: (BuildContext context) {
        return WebViewWidget(
          controller: _controller1,
        );
      }),
    );
  }

  Future getUserProfileFromCode(pingCode) async {
    debugPrint('===>Getting User Profile');
    SharedPreferences session = await SharedPreferences.getInstance();
    try {
      http.Response response;
      response =
          await http.post(Uri.parse(AppConstants.FED_AUTH_TOKEN), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'PF=gAvY5cL83UUST7sxealWO2',
      }, body: {
        "code": pingCode,
        'client_id': AppConstants.CLIENT_ID,
        'grant_type': 'authorization_code',
        'redirect_uri': AppConstants.REDIRECT_URI,
        'client_secret': AppConstants.CLIENT_SECRET,
        'scope': 'openid profile',
      });
      // debugPrint('===>User Profile Response:${response.body}');
      logger.d('===>User Response:${response.body}');
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);

        await session.setString(
            AppConstants.ACCESS_TOKEN, mapResponse['access_token']);

        employeeAuthentication(mapResponse['access_token']);
      } else {
        _onClearCookies();
      }
    } on SocketException {
      _showToast();
    } catch (e) {
      Get.offAndToNamed(AppPages.RETRY_ACCESS_DENIED);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => RetryAccessDenied(),
      //     ));
    }
  }

  retryFuture(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }

  Future employeeAuthentication(authorization) async {
    try {
      http.Response response;
      response = await http.post(
          Uri.parse("${AppConstants.BASE_URL}appData/employeeAuthentication"),
          body: {
            'access_token': authorization
          },
          headers: {
            'Accept': '*/*',
            'X_AUTH_TOKEN': authorization,
            'Authorization': 'Bearer $authorization',
            'Ocp-Apim-Trace': true.toString(),
            'Ocp-Apim-Subscription-Key': AppConstants.SUBSCRIPTION_KEY,
          });
      // debugPrint('==>Employee Response ${response.body}');
      logger.v('====>Employee Response:${response.body}');
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);
        SharedPreferences session = await SharedPreferences.getInstance();
        await session.setString(AppConstants.TOKEN, mapResponse['token']);
        await session.setString(
            AppConstants.EMAIL, mapResponse['user']['email']);
        await session.setString(
            AppConstants.NAME, mapResponse['user']['first_name']);

        debugPrint('===>Before Token check');
        if (session.getString(AppConstants.DEFAULT_GEO) != null &&
            session.getString(AppConstants.DEFAULT_GEO)!.trim().isNotEmpty &&
            session.getString(AppConstants.DEFAULT_GEO_VALUE) != null &&
            session
                .getString(AppConstants.DEFAULT_GEO_VALUE)!
                .trim()
                .isNotEmpty) {
          debugPrint('===>After Token check');
          _onClearCookies();
          Get.offAndToNamed(AppPages.INITIAL);
          // Get.offAndToNamed(AppPages.PERSONA_SCREEN);
        } else {
          _onClearCookies();
          Get.offAndToNamed(AppPages.PERSONA_SCREEN);
        }
      } else if (response.statusCode == 401) {
        _onClearCookies();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
      } else if (response.statusCode == 403) {
        _onClearCookies();
        Get.offAndToNamed(AppPages.ACCESS_DENIED,
            arguments: AccessDeniedBody(
                statusCode: response.statusCode,
                reason: "ACCESS_DENIED_BY_BACKEND"));
      } else {
        _onClearCookies();
        Get.offAndToNamed(AppPages.RETRY_ACCESS_DENIED);
      }
    } catch (e) {
      _onClearCookies();
    }
  }

  void _showToast() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text("You are not connected to internet"),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  // void _onClearCookies(BuildContext context) async {
  //   final WebViewCookieManager cookieManager = WebViewCookieManager();
  //   final bool hadCookies = await cookieManager.clearCookies();
  //   String message = 'There were cookies. Now, they are gone!';
  //   if (!hadCookies) {
  //     message = 'There are no cookies.';
  //   }
  // }

  void _onClearCookies() async {
    final WebViewCookieManager cookieManager = WebViewCookieManager();
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
  }
}
