import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final WebViewController _controller;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  final WebViewController webViewController = WebViewController();

  final AuthController authCtlr =
      Get.put<AuthController>(AuthController(authRepo: Get.find()));

  @override
  void initState() {
    super.initState();
    // authCtlr.clearSharedData();
    FirebaseCrashlytics.instance.log("Login Started");

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

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            FirebaseCrashlytics.instance.log("Login : URL Loaded");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
          Page resource error:
            code: ${error.errorCode}
            description: ${error.description}
            errorType: ${error.errorType}
            isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('${AppConstants.REDIRECT_URI}?code=')) {
              FirebaseCrashlytics.instance.log("Login : Code Generated");
              debugPrint('blocking navigation to ${request.url}');
              var uri = Uri.dataFromString(request.url);
              var code = uri.queryParameters['code'];

              authCtlr.getUserProfile(code ?? '');

              return NavigationDecision.prevent;
            } else if (request.url.contains('access_denied')) {
              FirebaseCrashlytics.instance.log("Login : Access Denied");
              FirebaseAnalytics.instance.logEvent(
                  name: 'fed_auth_login',
                  parameters: <String, dynamic>{'response': request.url});
              Get.offAndToNamed(AppPages.RETRY_ACCESS_DENIED);
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            openDialog(request);
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

    _controller = controller;
  }

  Future<void> openDialog(HttpAuthRequest httpRequest) async {
    final TextEditingController usernameTextController =
        TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  autofocus: true,
                  controller: usernameTextController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passwordTextController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // Explicitly cancel the request on iOS as the OS does not emit new
            // requests when a previous request is pending.
            TextButton(
              onPressed: () {
                httpRequest.onCancel();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                httpRequest.onProceed(
                  WebViewCredential(
                    user: usernameTextController.text,
                    password: passwordTextController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Authenticate'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Command Center',
          style: GoogleFonts.ptSans(color: AppColors.black),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );

    //   final size = MediaQuery.of(context).size;
    //   return Scaffold(
    //     backgroundColor: AppColors.white,
    //     body: SingleChildScrollView(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           // const LoginAppBar(),
    //           // Container(
    //           //   height: size.height / 3.8,
    //           //   color: MyColors.primary,
    //           // ),
    //           Padding(
    //             padding: const EdgeInsets.only(top: 80, bottom: 40, left: 30),
    //             child: Text(
    //               'Login',
    //               style: GoogleFonts.ptSans(
    //                 fontWeight: FontWeight.bold,
    //                 color: AppColors.black,
    //                 fontSize: 40,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             decoration: const BoxDecoration(color: Colors.white),
    //             padding: const EdgeInsets.only(
    //                 left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
    //             child: TextFormField(
    //               keyboardType: TextInputType.text,
    //               // controller: _userPasswordController,
    //               decoration: InputDecoration(
    //                 labelText: 'Ping ID',
    //                 labelStyle: GoogleFonts.ptSans(
    //                     fontSize: 18, fontWeight: FontWeight.w400),
    //                 hintText: 'example@pg.com',
    //                 hintStyle: GoogleFonts.ptSans(
    //                     fontSize: 18, fontWeight: FontWeight.w400),
    //                 // labelStyle: TextStyle(fontSize: 16),
    //                 border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(10)),
    //                 enabled: true,
    //                 focusedBorder: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(10)),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             decoration: const BoxDecoration(color: Colors.white),
    //             padding: const EdgeInsets.all(20.0),
    //             child: TextFormField(
    //               keyboardType: TextInputType.text,
    //               // controller: _userPasswordController,
    //               obscureText: !_passwordVisible,
    //               //This will obscure text dynamically

    //               decoration: InputDecoration(
    //                 labelText: 'Password',
    //                 hintText: '******',
    //                 labelStyle: GoogleFonts.ptSans(
    //                     fontSize: 18, fontWeight: FontWeight.w400),
    //                 hintStyle: GoogleFonts.ptSans(
    //                     fontSize: 18, fontWeight: FontWeight.w400),
    //                 border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(10)),
    //                 focusedBorder: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(10)),
    //                 // Here is key idea
    //                 suffixIcon: IconButton(
    //                   icon: Icon(
    //                     // Based on passwordVisible state choose the icon
    //                     _passwordVisible
    //                         ? Icons.visibility
    //                         : Icons.visibility_off,
    //                     color: Theme.of(context).primaryColorDark,
    //                   ),
    //                   onPressed: () {
    //                     // Update the state i.e. toogle the state of passwordVisible variable
    //                     setState(() {
    //                       _passwordVisible = !_passwordVisible;
    //                     });
    //                   },
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
    //             child: SizedBox(
    //               height: 56,
    //               width: size.width,
    //               child: ElevatedButton(
    //                 onPressed: () {
    //                   Get.toNamed(AppPages.PURPOSE_SCREEN);
    //                 },
    //                 style: ElevatedButton.styleFrom(
    //                   backgroundColor: AppColors.primary,
    //                   elevation: 0,
    //                   shape: const StadiumBorder(),
    //                 ),
    //                 child: Text(
    //                   'Sign On',
    //                   style: GoogleFonts.ptSans(
    //                       letterSpacing: 0.8,
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
  }
}
