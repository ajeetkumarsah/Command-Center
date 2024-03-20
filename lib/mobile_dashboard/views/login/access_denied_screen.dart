import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';

class AccessDeniedBody {
  final int statusCode;
  final String reason;
  AccessDeniedBody({required this.statusCode, required this.reason});
}

class AccessDeniedScreen extends StatefulWidget {
  const AccessDeniedScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AccessDeniedState createState() => _AccessDeniedState();
}

class _AccessDeniedState extends State<AccessDeniedScreen> {
  // AccessDeniedBody args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: const Color(0xff6F81E6),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.blueLighter])),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/icon/img_cc.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Hi User, \nYou don't seem to have access to the Command Center.",
                  // "Access Denied!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: Text(
                  "Please find the SOP below \n",
                  // "You do not have access to this service. Reason Code {args.reason} \n Please contact the below.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const Text(
                "For queries contact below",
                // "You do not have access to this service. Reason Code {args.reason} \n Please contact the below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Nithin Balaaji (dv.nb@pg.com)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    _onClearCookies(context);
                    main();
                  },
                  style: ElevatedButton.styleFrom(
                    // shape: RoundedRectangleBorder(
                    //   side: BorderSide(color: kPrimaryColor),
                    //   borderRadius: BorderRadius.circular(5),
                    // ),
                    textStyle: const TextStyle(
                        // color: kPrimaryColor
                        ),
                    backgroundColor: Colors.white,
                    // color: kPrimaryColor,
                    // textColor: Colors.white,
                  ),
                  child: const SizedBox(
                    height: 44,
                    child: Center(
                      child: Text(
                        "Go Back",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Version Code:  ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  FutureBuilder(
                    future: getVersionNumber(),
                    builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) =>
                        Text(
                      snapshot.hasData ? "${snapshot.data}" : "Loading ...",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    print(version);
    return version;
  }

  Future<String> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionCode = packageInfo.buildNumber;
    return versionCode;
  }

  Future<void> main() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    await session.remove('token');
    await session.remove("id");
    await session.remove("token");
    await session.remove("name");
    await session.remove("email");
    await session.remove("FCMToken");
    Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
    // Navigator.of(context).pushAndRemoveUntil(
    //   // the new route
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => FedAuthLoginPage(),
    //   ),
    //   (Route route) => false,
    // );
  }

  void _onClearCookies(BuildContext context) async {
    // final WebViewCookieManager cookieManager = WebViewCookieManager();
    // final bool hadCookies = await cookieManager.clearCookies();
    // String message = 'There were cookies. Now, they are gone!';
    // if (!hadCookies) {
    //   message = 'There are no cookies.';
    // }
  }

  // void _showToast(BuildContext context, int statusCode) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: Text("$statusCode"),
  //       action: SnackBarAction(
  //           label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
  //     ),
  //   );
  // }
}
