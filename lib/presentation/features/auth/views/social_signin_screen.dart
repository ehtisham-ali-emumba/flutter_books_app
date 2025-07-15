import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SocialSignInScreen extends StatelessWidget {
  const SocialSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppStrings.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AppText(AppStrings.signInWithGoogleAcc, kind: TextKind.body),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.replace('/home'),
              child: AppText(
                AppStrings.signInWithGoogle,
                kind: TextKind.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
