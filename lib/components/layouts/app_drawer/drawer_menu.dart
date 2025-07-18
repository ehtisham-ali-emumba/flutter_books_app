import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerMenu extends StatelessWidget {
  final VoidCallback? onItemSelected;

  const DrawerMenu({super.key, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: colorScheme.primary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.verified_user, color: Colors.green, size: 30.0),
              SizedBox(height: 10),
              Text(
                "Super User",
                style: TextStyle(color: colorScheme.onPrimary),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            onItemSelected?.call();
            context.go('/home');
          },
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () {
            onItemSelected?.call();
            context.go('/settings');
          },
        ),
      ],
    );
  }
}
