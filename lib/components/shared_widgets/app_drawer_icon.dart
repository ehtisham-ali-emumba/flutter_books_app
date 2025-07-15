import 'package:books/components/layouts/app_drawer_layout.dart';
import 'package:flutter/material.dart';

class AppDrawerIcon extends StatelessWidget {
  const AppDrawerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        AppDrawerLayout.scaffoldKey.currentState?.openDrawer();
      },
    );
  }
}
