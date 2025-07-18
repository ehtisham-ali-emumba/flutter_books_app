import 'package:flutter/material.dart';

import '../../../presentation/shared_view_models/app_drawer_provider.dart';
import 'app_drawer_layout.dart';
import 'drawer_menu.dart';

class AppDrawerResponsiveLayout extends StatefulWidget {
  final Widget child;

  const AppDrawerResponsiveLayout({super.key, required this.child});

  @override
  State<AppDrawerResponsiveLayout> createState() =>
      _AppDrawerResponsiveLayoutState();
}

class _AppDrawerResponsiveLayoutState extends State<AppDrawerResponsiveLayout> {
  bool _drawerOpen = false;
  static const double drawerWidth = 250.0;
  static const Duration animationDuration = Duration(milliseconds: 300);

  void _toggleDrawer() {
    setState(() => _drawerOpen = !_drawerOpen);
  }

  void _onMenuSelect() {
    setState(() => _drawerOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return DrawerControllerProvider(
      toggleDrawer: _toggleDrawer,
      child: Scaffold(
        key: AppDrawerLayout.scaffoldKey,
        body: Row(
          children: [
            AnimatedContainer(
              duration: animationDuration,
              width: _drawerOpen ? drawerWidth : 0,
              curve: Curves.easeInOut,
              child: IgnorePointer(
                ignoring: !_drawerOpen,
                child: Opacity(
                  opacity: _drawerOpen ? 1.0 : 0.0,
                  child: Drawer(
                    elevation: 0,
                    child: DrawerMenu(onItemSelected: _onMenuSelect),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: animationDuration,
                curve: Curves.easeInOut,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
