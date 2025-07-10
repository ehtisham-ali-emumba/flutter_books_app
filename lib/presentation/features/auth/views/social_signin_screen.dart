import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SocialSignInScreen extends StatelessWidget {
  const SocialSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("SocialSignInScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Sign in with your Google account to continue"),
            ElevatedButton(
              onPressed: () {
                // Your login logic
                context.replace('/home'); // Navigate to Home (inside drawer)
              },
              child: Text("Sign in with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
