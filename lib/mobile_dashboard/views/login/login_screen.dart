import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginAppBar(),
            // Container(
            //   height: size.height / 3.8,
            //   color: MyColors.primary,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 40, left: 30),
              child: Text(
                'Login',
                style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                // controller: _userPasswordController,
                decoration: InputDecoration(
                  labelText: 'Ping ID',
                  labelStyle: GoogleFonts.ptSans(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  hintText: 'example@pg.com',
                  hintStyle: GoogleFonts.ptSans(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  // labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  enabled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                  labelText: 'Password',
                  hintText: '******',
                  labelStyle: GoogleFonts.ptSans(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  hintStyle: GoogleFonts.ptSans(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
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
              child: SizedBox(
                height: 56,
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppPages.PURPOSE_SCREEN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Sign On',
                    style: GoogleFonts.ptSans(
                        letterSpacing: 0.8,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
              image: AssetImage('assets/png/E72.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: size.width / 2.9,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/png/masklogin.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: size.width / 2.9,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/png/E73.png'),
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }
}
