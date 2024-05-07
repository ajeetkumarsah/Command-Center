// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:command_centre/activities/select_profile_screen.dart';
import 'package:command_centre/helper/global/global.dart' as globals;
import 'package:command_centre/activities/pglogin/retry_access_denied.dart';
import 'package:command_centre/helper/env/env_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'accessdenied.dart';

void main() => runApp(MaterialApp(home: FedAuthLoginPage()));

class FedAuthLoginPage extends StatefulWidget {
  @override
  _FedAuthLoginPageState createState() => _FedAuthLoginPageState();
}

class _FedAuthLoginPageState extends State<FedAuthLoginPage> {
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
          },
          onPageStarted: (String url) {
          },
          onPageFinished: (String url) {
          },
          onWebResourceError: (WebResourceError error) {
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("http://localhost:3000/callback?code=")) {
              var uri = Uri.dataFromString(request.url);
              var code = uri.queryParameters['code'];

              getUserProfileFromCode(code);
              return NavigationDecision.prevent;
            } else if (request.url.contains('access_denied')) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RetryAccessDenied()));
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
      ..loadRequest(Uri.parse(EnvUtils.fedAuthUrl));

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
        title: const Text('Command Center'),
        automaticallyImplyLeading: false,
      ),
      body: Builder(builder: (BuildContext context) {
        return WebViewWidget(
          controller: _controller1,
        );
      }),
    );
  }

  Future getUserProfileFromCode(pingCode) async {
    try {
      http.Response response;
      response = await http.post(Uri.parse(EnvUtils.fedAuthTokenUrl), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'PF=gAvY5cL83UUST7sxealWO2',
      }, body: {
        "code": pingCode,
        'client_id': EnvUtils.clientID,
        'grant_type': 'authorization_code',
        'redirect_uri': EnvUtils.redirectURI,
        'client_secret': EnvUtils.clientSecret,
        'scope': 'openid profile',
      });

      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);
        SharedPreferences session = await SharedPreferences.getInstance();
        await session.setString("authorization", mapResponse['access_token']);
        globals.authorization = session.getString("authorization")!;
        employeeAuthentication(mapResponse['access_token']);
      } else {
        _onClearCookies(context);
      }
    } on SocketException {
      _showToast(context);
    } catch (e) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RetryAccessDenied(),
          ));
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
          Uri.parse("${EnvUtils.baseURL}/appData/employeeAuthentication"),
          body: {
            'access_token': authorization
          },
          headers: {
            'Accept': '*/*',
            'X_AUTH_TOKEN': authorization,
            'Authorization': 'Bearer $authorization',
            'Ocp-Apim-Trace': true.toString(),
            'Ocp-Apim-Subscription-Key': EnvUtils.subscriptionKey
          });
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body);
        SharedPreferences session = await SharedPreferences.getInstance();
        await session.setString("token", mapResponse['token']);
        await session.setString("email", mapResponse['user']['email']);
        await session.setString("name", mapResponse['user']['first_name']);
        globals.token = session.getString("token")!;
        globals.name = session.getString("name")!;
        globals.email = session.getString("email")!;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectProfile(),
            ));
      } else if (response.statusCode == 401) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => FedAuthLoginPage()));
      } else if (response.statusCode == 403) {
        _onClearCookies(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AccessDenied(
                    statusCode: response.statusCode,
                    reason: "ACCESS_DENIED_BY_BACKEND")));
      } else {
        _onClearCookies(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RetryAccessDenied(),
            ));
      }
    } catch (e) {
      _onClearCookies(context);
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text("You are not connected to internet"),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _onClearCookies(BuildContext context) async {
    final WebViewCookieManager cookieManager = WebViewCookieManager();
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    // ignore: deprecated_member_use
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text(message),
    // ));
  }
}
