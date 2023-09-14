import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/web_dashboard/filters_table.dart';
import 'package:command_centre/web_dashboard/select_division_screen.dart';
import 'package:command_centre/web_dashboard/select_profile_screen.dart';
import 'package:command_centre/web_dashboard/table.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/cc_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/common_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/coverage_distribution_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/fb_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/gp_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/retailing_container_drawer.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/summary_container_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'activities/responsive.dart';
import 'activities/select_profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await SharedPreferencesUtils.init();
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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: DependentDropdowns(),
        initialRoute: "/",
        routes: {
          '/': (context) => SharedPreferencesUtils.getBool('business') == true
      ? const ResponsiveHomePage(initial: true,initialLoading: false, items: [],)
          : const SelectProfileScreenWeb(),
          '/fbContainer':(context) =>const FBContainerDrawer(),
          '/gpContainer':(context) =>const GPContainerDrawer(),
          '/ccContainer':(context) =>const CCContainerDrawer(),
          '/summaryContainer':(context) =>const SummaryContainerDrawer(initial: true,initialLoading: false, items: [],),
          '/cndContainer':(context) =>const CoverageDistributionContainerDrawer(),
          '/retailingContainer':(context) =>const RetailingContainerDrawer(),
          '/commonContainer':(context) =>const CommonContainerDrawer(),
          '/profilescreen':(context) =>const SelectProfileScreenWeb(),
          '/divisionscreen':(context) =>const SelectDivisionScreen(initInitial: false,),
          '/summaryscreen': (context) => ResponsiveHomePage(
          initial: false,
          initialLoading: true,
          items: const ['allIndia']
          ),
        },
      //   home: MyHomePage(),
        // home: SharedPreferencesUtils.getBool('business') == true
        //     ? const ResponsiveHomePage()
        //     : const SelectDivisionScreen(),
        // home: SplashScreen(),
        // home: SelectDivisionScreen(initInitial: true,),
        // home: const CoverageScreen(itemCount: [], divisionCount: [], siteCount: [], branchCount: [],),
        // initialRoute: RoutesName.splash,
        // onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
