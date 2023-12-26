import 'package:command_centre/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../utils/colors/colors.dart';
import '../utils/comman/login_appbar.dart';
import '../utils/comman/widget/login_header_widget.dart';
import '../utils/style/text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginAppBar(),
            // Container(
            //   height: size.height / 3.8,
            //   color: MyColors.primary,
            // ),
            const Padding(
              padding: EdgeInsets.only(top: 80, bottom: 40, left: 30),
              child: LoginHeaderWidget(title: 'Login'),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                // controller: _userPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Ping ID',
                  labelStyle: TextStyle(fontSize: 18, fontFamily: fontFamily, fontWeight: FontWeight.w400),
                  hintText: 'example@pg.com',
                  hintStyle: TextStyle(fontSize: 18, fontFamily: fontFamily, fontWeight: FontWeight.w400),
                  // labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  enabled: true,
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                // controller: _userPasswordController,
                obscureText: !_passwordVisible,
                //This will obscure text dynamically

                decoration: InputDecoration(
                  labelText: '',
                  hintText: '',
                  labelStyle: const TextStyle(fontSize: 18, fontFamily: fontFamily, fontWeight: FontWeight.w400),
                  hintStyle: TextStyle(fontSize: 18, fontFamily: fontFamily, fontWeight: FontWeight.w400),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Container(
                height: 56,
                width: size.width,
                child: ElevatedButton(

                  onPressed: () {Navigator.pushNamed(context, RoutesName.purpose);},
                  style: ElevatedButton.styleFrom(backgroundColor: MyColors.toggletextColor, elevation: 0, shape: const StadiumBorder()),
                  child: const Text('Sign On', style: TextStyle(letterSpacing: 0.8, fontSize: 18, fontFamily: fontFamily, fontWeight: FontWeight.w700),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

