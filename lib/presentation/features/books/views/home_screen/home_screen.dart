import 'package:books/components/shared_widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'app_color_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("HomeScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            AppText("All Genres", kind: TextKind.heading),
            AppDarkModeToggle(),
          ],
        ),
      ),
    );
  }
}
