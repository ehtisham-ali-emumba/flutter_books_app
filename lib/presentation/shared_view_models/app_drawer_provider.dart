import 'package:flutter/material.dart';

class DrawerControllerProvider extends InheritedWidget {
  final VoidCallback? toggleDrawer;

  const DrawerControllerProvider({
    super.key,
    required super.child,
    this.toggleDrawer,
  });

  static DrawerControllerProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DrawerControllerProvider>();
  }

  @override
  bool updateShouldNotify(DrawerControllerProvider oldWidget) {
    return toggleDrawer != oldWidget.toggleDrawer;
  }
}
