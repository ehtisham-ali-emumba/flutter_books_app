import 'package:flutter/material.dart';

import 'app_drawer_layout.dart';
import 'drawer_menu.dart';

class AppDrawerMobileLayout extends StatelessWidget {
  final Widget child;

  const AppDrawerMobileLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppDrawerLayout.scaffoldKey,
      drawer: Drawer(
        child: DrawerMenu(onItemSelected: () => Navigator.pop(context)),
      ),
      body: child,
    );
  }
}
