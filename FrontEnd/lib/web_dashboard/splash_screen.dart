
import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../utils/style/text_style.dart';

class WebSplashScreen extends StatefulWidget {
  const WebSplashScreen({Key? key}) : super(key: key);

  @override
  State<WebSplashScreen> createState() => _WebSplashScreenState();
}

class _WebSplashScreenState extends State<WebSplashScreen> {
  var year = DateTime.now().year;

  final String _url =
      // 'https://fedauthtst.pg.com/as/authorization.oauth2?client_id=Command%20Center&response_type=code&scope=openid%20pingid%20email%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback';
      'https://fedauthtst.pg.com/as/authorization.oauth2?client_id=Command%20Center&response_type=code&scope=openid%20pingid%20email%20profile&redirect_uri=https%3A%2F%2Fcommandcentrewebapp.ase1apxnp.pgcloud.com%2Fcallback';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // divisionFilterAPI();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SizedBox(
                height: 310,
                width: 500,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 3,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 110,
                            width: size.width,
                            decoration: const BoxDecoration(
                                color: Color(0xffD4DBF9),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25, top: 25),
                              child: Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Welcome",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: MyColors.textColor,
                                          fontFamily: fontFamily,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Command Center",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: MyColors.textColor,
                                          fontFamily: fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    "assets/icon/profile.png",
                                    // height: 110,
                                    // width: 180,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Image.asset(
                            "assets/icon/pingid.png",
                            height: 50,
                            width: 100,
                          ),
                          SizedBox(
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () async {
                                // await _launchUrl();
                                html.window.open(_url, "_self");
                                // print(html.window.console.memory);
                                // Navigator.pushNamed(context, '/ping/oauth2');
                              },
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(
                                        width: 1.0, color: Colors.red)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                              child: const Text(
                                "Ping Login",
                                style: TextStyle(
                                    fontFamily: fontFamily, color: Colors.red),
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                          top: 80,
                          left: 20,
                          child: Image.asset(
                            "assets/icon/icon.png",
                            height: 80,
                            width: 80,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                children: [
                  const WidgetSpan(
                      child: Icon(
                    Icons.copyright,
                    color: MyColors.textColor,
                    size: 14,
                  )),
                  TextSpan(
                    text: '$year Tranzita. Designed and Developed',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: MyColors.textColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                  const WidgetSpan(
                      child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 14,
                  )),
                  const TextSpan(
                    text: 'by Tranzita',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: MyColors.textColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ],
              ),
            )
            // Text(
            //   "\u00a9 $year Tranzita. Designed and Developed by Tranzita",
            //   style: TextStyle(
            //     fontWeight: FontWeight.w400,
            //     fontSize: 14,
            //     color: MyColors.textColor,
            //     fontFamily: fontFamily,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
