
import 'package:command_centre/activities/pglogin/fedauth_login.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RetryAccessDenied extends StatefulWidget {
  const RetryAccessDenied({Key? key}) : super(key: key);

  @override
  _RetryAccessDeniedState createState() => _RetryAccessDeniedState();
}

class _RetryAccessDeniedState extends State<RetryAccessDenied>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationValue;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationValue =
        Tween<double>(begin: 0.9, end: 1.1).animate(_animationController);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _animationValue,
                    child: Image.asset(
                      "assets/icon/icon.png",
                      height: 250,
                      width: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Oops!',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: const Text(
                      'Something is wrong. Try Again After sometime.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const TextWidget(
                  //     title: 'Your booking has been confirmed.',
                  //     color: MyColors.primaryGrey,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 14),
                ],
              ),
            ),
            Positioned(
              left: 70,
              right: 70,
              bottom: 20,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // primary: MyColors.primaryBlue,
                      ),
                  onPressed: () {
                    _onClearCookies(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => FedAuthLoginPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Reload",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
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