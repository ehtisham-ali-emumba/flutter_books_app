import 'package:books/presentation/features/books/views/home_screen/app_dark_mode_toggle.dart';
import 'package:books/presentation/features/books/views/home_screen/app_drawer_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppDrawerIcon(),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // App theme section
          _buildSectionHeader(context, "Display"),
          _buildSettingsTile(
            context,
            title: "Dark Mode",
            subtitle: "Toggle dark/light theme",
            trailing: AppDarkModeToggle(),
          ),

          const Divider(color: Colors.grey),

          // Account section
          _buildSectionHeader(context, "Account"),
          _buildSettingsTile(
            context,
            title: "Profile",
            subtitle: "Manage your profile information",
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to profile screen
            },
          ),

          const Divider(color: Colors.grey),

          // Favorite books button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                context.push("/favorite-books");
              },
              icon: const Icon(Icons.favorite),
              label: const Text('My Favorite Books'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),

          // About section
          _buildSectionHeader(context, "About"),
          _buildSettingsTile(context, title: "App Version", subtitle: "1.0.0"),
          _buildSettingsTile(
            context,
            title: "Terms & Privacy Policy",
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: onTap,
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        1.0,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
    );
  }
}
