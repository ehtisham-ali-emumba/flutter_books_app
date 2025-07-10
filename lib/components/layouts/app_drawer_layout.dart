import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawerLayout extends StatelessWidget {
  final Widget child;

  const AppDrawerLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.verified_user, color: Colors.green, size: 30.0),
                  SizedBox(height: 10),
                  Text(
                    "Super User",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ListTile(title: Text('Home'), onTap: () => context.go('/home')),
            ListTile(
              title: Text('Settings'),
              onTap: () => context.go('/settings'),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
