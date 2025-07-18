import 'package:books/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

import 'app_drawer_mobile_layout.dart';
import 'app_drawer_responsive_layout.dart';

class AppDrawerLayout extends StatelessWidget {
  final Widget child;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  const AppDrawerLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (R.mobile()) {
      return AppDrawerMobileLayout(child: child);
    } else {
      return AppDrawerResponsiveLayout(child: child);
    }
  }
}
