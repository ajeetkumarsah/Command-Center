import 'package:command_centre/activities/business_screen.dart';
import 'package:command_centre/activities/home_screen.dart';
import 'package:command_centre/activities/intro_screen.dart';
import 'package:command_centre/activities/login_screen.dart';
import 'package:command_centre/activities/marketvisit_screen.dart';
import 'package:command_centre/activities/purpose_screen.dart';
import 'package:command_centre/activities/splash_screen.dart';
import 'package:command_centre/mobile_dashboard/views/login/testing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'routes_name.dart';

class Routes{
  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=> SplashScreen());
      case RoutesName.intro:
        return MaterialPageRoute(builder: (BuildContext context)=> IntroScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=> LoginScreen());
      // case RoutesName.pglogin:
      //   return MaterialPageRoute(builder: (BuildContext context)=> FedAuthLoginPage());
      case RoutesName.purpose:
        return MaterialPageRoute(builder: (BuildContext context)=> PurposeScreen(isBool: false,));
      case RoutesName.business:
        return MaterialPageRoute(builder: (BuildContext context)=> BusinessScreen());
      case RoutesName.marketvisit:
        return MaterialPageRoute(builder: (BuildContext context)=> MarketVisit());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=> HomePage());
      case RoutesName.loginTest:
        return MaterialPageRoute(builder: (BuildContext context)=> WebViewExample());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No routes found'),
            ),
          );
        });
    }
  }
}