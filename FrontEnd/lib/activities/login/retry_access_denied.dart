import 'package:flutter/material.dart';
import '../../utils/colors/colors.dart';
import '../../utils/routes/routes_name.dart';
import 'fedauth_login.dart';

class RetryAccessDenied extends StatefulWidget {
  const RetryAccessDenied({Key? key}) : super(key: key);

  @override
  RetryAccessDeniedState createState() => RetryAccessDeniedState();
}

class RetryAccessDeniedState extends State<RetryAccessDenied>
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
                        color: MyColors.grey,
                        fontSize: 25),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                      'Something went wrong.\n Please check your internet connection or try again after sometime.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 70,
              right: 70,
              bottom: 20,
              child: BasicElevatedButton(
                  text: 'Reload',
                  onPressed: () { onClearCookies(context);
                  Navigator.pushNamed(context, RoutesName.pglogin); },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BasicElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? fontsize;
  const BasicElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.fontsize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isDarkTheme ? MyColors.primaryDark : MyColors.primary)),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontsize,
          color: MyColors.whiteColor,
        ),
      ),
    );
  }
}