import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.width / 2.9,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/app_bar/E72.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: size.width / 2.9,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/app_bar/masklogin.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: size.width / 2.9,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/app_bar/E73.png'),
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }
}