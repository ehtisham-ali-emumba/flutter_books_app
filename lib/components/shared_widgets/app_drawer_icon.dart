import 'package:books/components/layouts/app_drawer/app_drawer_layout.dart';
import 'package:books/core/responsive/responsive.dart';
import 'package:books/presentation/shared_view_models/app_drawer_provider.dart';
import 'package:flutter/material.dart';

class AppDrawerIcon extends StatelessWidget {
  const AppDrawerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        if (R.mobile()) {
          AppDrawerLayout.scaffoldKey.currentState?.openDrawer();
        } else {
          final toggleDrawer = DrawerControllerProvider.of(
            context,
          )?.toggleDrawer;
          toggleDrawer?.call();
        }
      },
    );
  }
}
