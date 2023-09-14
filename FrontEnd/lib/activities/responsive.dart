import 'package:command_centre/activities/home_screen.dart';
import 'package:flutter/material.dart';

import '../utils/responsive_layout/responsive_layout.dart';
import '../web_dashboard/utils/drawer_container/summary_container_drawer.dart';

class ResponsiveHomePage extends StatefulWidget {
  final bool initial;
  final bool initialLoading;
  final List items;
  const ResponsiveHomePage({Key? key, required this.initial, required this.initialLoading, required this.items}) : super(key: key);

  @override
  State<ResponsiveHomePage> createState() => _ResponsiveHomePageState();
}

class _ResponsiveHomePageState extends State<ResponsiveHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(desktopBody: SummaryContainerDrawer(initial: widget.initial, initialLoading: widget.initialLoading, items: widget.items,), mobileBody: const HomePage()),
    );
  }
}
