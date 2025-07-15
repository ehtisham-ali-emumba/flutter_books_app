import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTabLayout extends StatefulWidget {
  final Widget child;

  const AppTabLayout({super.key, required this.child});

  @override
  State<AppTabLayout> createState() => _AppTabLayoutState();
}

class _AppTabLayoutState extends State<AppTabLayout> {
  int _index = 0;

  static const tabs = ['/home', '/explore'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() => _index = value);
          context.go(tabs[value]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        ],
      ),
    );
  }
}
