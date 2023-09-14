import 'dart:async';
import 'package:command_centre/activities/home_screen.dart';
import 'package:command_centre/activities/login/retry_access_denied.dart';
import 'package:command_centre/activities/purpose_screen.dart';
import 'package:command_centre/activities/select_profile_screen.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../helper/app_urls.dart';
import '../../helper/env/env_utils.dart';
import 'accessdenied.dart';
import 'login_controller.dart';

class FedAuthLoginPage extends StatefulWidget {
  @override
  _FedAuthLoginPageState createState() => _FedAuthLoginPageState();
}

class _FedAuthLoginPageState extends State<FedAuthLoginPage> {
  late final WebViewController _controller;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  // late final WebViewCookieManager cookieManager;
  String fedAuthUrl ='https://fedauthtst.pg.com/as/authorization.oauth2?client_id=Command%20Center&response_type=code&scope=openid%20pingid%20email%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback';
  // String fedAuthUrl ='${URL.FedAuthBaseUrl}/${URL.FedAuthAuthorizationEndpoint}?client_id=${environment['fedAuthConfig']['clientID']}&response_type=${environment['fedAuthConfig']['response_type']}&redirect_uri=${environment['fedAuthConfig']['redirectURI']}&scope=${environment['fedAuthConfig']['scope']}';
  bool isLoading = false;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    // checkInternet().checkConnection(context);
    // FirebaseAnalytics.instance.logEvent(name: "LoginScreen");

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
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const RetryAccessDenied()));
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("http://localhost:3000/callback?code=")) {
              logger.v('blocking navigation to ${request.url}');
              var uri = Uri.dataFromString(request.url);
              var code = uri.queryParameters['code'];
              logger.v('Authorization Code: ${code}');
              // FirebaseAnalytics.instance.logEvent(name: code!);
              login(code);
              return NavigationDecision.prevent;
            }
            else if( request.url.contains('access_denied') ){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AccessDenied()));
              }
            logger.v('allowing navigation to ${request.url}');
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
      ..loadRequest(Uri.parse(fedAuthUrl))
    ;

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }

  Future login(pingCode) async {
    logger.v('Inside Login');
    logger.v('Authorization Code: ${pingCode}');
    // SharedPreferencesUtils.setString('pingCode', pingCode);
    LoginController().getAccessTokenFromCode(pingCode).then((isLoggedIn) {
      if (isLoggedIn) {
        bool business = SharedPreferencesUtils.getBool("business") ?? false;
        if(business){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
        }else{
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => const SelectProfile()));
        }
        // onClearCookies(context);

      } else {
        onClearCookies(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const RetryAccessDenied()));
      }
    });
  }
}

void onClearCookies(BuildContext context) async {
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  final bool hadCookies = await cookieManager.clearCookies();
  String message = 'There were cookies. Now, they are gone!';
  if (!hadCookies) {
    message = 'There are no cookies.';
  }
  // ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(message),
  );
  // );
}
