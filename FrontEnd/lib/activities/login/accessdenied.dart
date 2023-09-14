import 'package:flutter/material.dart';
import '../../utils/colors/colors.dart';
import '../../utils/sharedpreferences/sharedpreferences_utils.dart';
import 'fedauth_login.dart';

class AccessDenied extends StatefulWidget {
  final int? statusCode;

  const AccessDenied({Key? key, this.statusCode}) : super(key: key);

  @override
  AccessDeniedState createState() => AccessDeniedState();
}

class AccessDeniedState extends State<AccessDenied> {

  @override
  Widget build(BuildContext context) {
    //  final pCart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Container(
        color: const Color(0xff6F81E6),
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
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/images/warning.png",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Access Denied!",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: Text(
                  "You do not have access to this service.\n Please contact your Administrator.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Hirota, Tsuyoshi (hirota.t@pg.com)",
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
                  onPressed: () {
                    onClearCookies(context);
                    main();
                    // _showToast(context,widget.statusCode);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => FedAuthLoginPage(),
                    //     ));
                  },
                  style: ElevatedButton.styleFrom(
                    // shape: RoundedRectangleBorder(
                    //   side: BorderSide(color: kPrimaryColor),
                    //   borderRadius: BorderRadius.circular(5),
                    // ),
                    textStyle: const TextStyle(color: MyColors.primary),
                    primary: Colors.white,
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
                          color: MyColors.primary,
                        ),
                      ),
                    ),
                  ),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(0)),
                  // color: Colors.white,
                  // textColor:kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> main() async {
    await SharedPreferencesUtils.remove('token');
    await SharedPreferencesUtils.remove("id");
    await SharedPreferencesUtils.remove("token");
    //await session.remove("t_number");
    await SharedPreferencesUtils.remove("name");
    await SharedPreferencesUtils.remove("email");
    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => FedAuthLoginPage(),
      ),
          (Route route) => false,
    );
  }

  // void _onClearCookies(BuildContext context) async {
  //   final CookieManager cookieManager = CookieManager();
  //   final bool hadCookies = await cookieManager.clearCookies();
  //   String message = 'There were cookies. Now, they are gone!';
  //   if (!hadCookies) {
  //     message = 'There are no cookies.';
  //   }
  // }

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
