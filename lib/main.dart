import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:command_centre/activities/responsive.dart';
import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/select_profile_screen.dart';
import 'package:command_centre/web_dashboard/select_division_screen.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_dashboard.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/cc_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/fb_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/gp_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/common_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/summary_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/retailing_container_drawer.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/coverage_distribution_container_drawer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await SharedPreferencesUtils.init();
    // Future<bool> securityCheck() async {
    //   bool isJailBroken = await SafeDevice.isJailBroken;
    //   bool isCanMockLocation = await SafeDevice.canMockLocation;
    //   bool isRealDevice = await SafeDevice.isRealDevice;
    //   bool isSafeDevice = await SafeDevice.isSafeDevice;
    //
    //   if (isJailBroken || isCanMockLocation || !isRealDevice || !isSafeDevice) {
    //     return false;
    //   }
    //
    //   if (defaultTargetPlatform == TargetPlatform.android) {
    //     bool isDevelopmentModeEnable = await SafeDevice.isDevelopmentModeEnable;
    //     bool isOnExternalStorage = await SafeDevice.isOnExternalStorage;
    //
    //     if (isDevelopmentModeEnable || isOnExternalStorage) {
    //       return false;
    //     }
    //   }
    //
    //   return true;
    // }
    // bool isSecure = await securityCheck();
    // if(isSecure){
    //   // You can show an error message, log the event, or simply terminate the app.
    //   // For simplicity, this example terminates the app.
    //   print("Rooted device or emulator detected. The app cannot be installed.");
    //   return;
    // }
    // final context = SecurityContext.defaultContext;
    // context.allowLegacyUnsafeRenegotiation = true;
    // final httpClient = HttpClient(context: context);
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SheetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransportationProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Command Center',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:  MyListView(),
        // home: const RetailingScreen(),
        initialRoute: "/",
        routes: {
          '/': (context) => SharedPreferencesUtils.getBool('business') == true
              ? const ResponsiveHomePage(
                  initial: true,
                  initialLoading: false,
                  items: [],
                )
              : const SelectProfileScreenWeb(),
          '/fbsummary': (context) => const FBContainerDrawer(),
          '/gpsummary': (context) => const GPContainerDrawer(),
          '/ccsummary': (context) => const CCContainerDrawer(),
          '/summary': (context) => const SummaryContainerDrawer(
                initial: true,
                initialLoading: false,
                items: [],
              ),
          '/cndsummary': (context) =>
              const CoverageDistributionContainerDrawer(),
          '/retailingsummary': (context) => const RetailingContainerDrawer(),
          '/commonsummary': (context) => const CommonContainerDrawer(),
          '/profilescreen': (context) => const SelectProfileScreenWeb(),
          '/divisionscreen': (context) => const SelectDivisionScreen(
                initInitial: false,
              ),
          '/summaryscreen': (context) => const ResponsiveHomePage(
              initial: true, initialLoading: true, items: ['allIndia']),
          '/supplydashboardscreen': (context) => const SupplyChainDashBoard()
        },
        // home: SupplyChainDashBoard(),
        // initialRoute: "/",
        // routes: {
        //   '/': (context) => SharedPreferencesUtils.getBool('business') == true
        //       ? const ResponsiveHomePage(
        //           initial: true,
        //           initialLoading: false,
        //           items: [],
        //         )
        //       : const SelectProfileScreenWeb(),
        //   '/fbsummary': (context) => const FBContainerDrawer(),
        //   '/gpsummary': (context) => const GPContainerDrawer(),
        //   '/ccsummary': (context) => const CCContainerDrawer(),
        //   '/summary': (context) => const SummaryContainerDrawer(
        //         initial: true,
        //         initialLoading: false,
        //         items: [],
        //       ),
        //   '/cndsummary': (context) =>
        //       const CoverageDistributionContainerDrawer(),
        //   '/retailingsummary': (context) => const RetailingContainerDrawer(),
        //   '/commonsummary': (context) => const CommonContainerDrawer(),
        //   '/profilescreen': (context) => const SelectProfileScreenWeb(),
        //   '/divisionscreen': (context) => const SelectDivisionScreen(
        //         initInitial: false,
        //       ),
        //   '/summaryscreen': (context) => const ResponsiveHomePage(
        //       initial: true, initialLoading: true, items: ['allIndia']),
        // },
      ),
    );
  }
}


///102248485318
///102249274959