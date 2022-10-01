import 'package:flutter/material.dart';

import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<ThemeMode>(
              value: controller.themeMode,
              decoration: const InputDecoration(
                labelText: 'Theme',
                border: OutlineInputBorder(),
              ),
              onChanged: controller.updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            DropdownButtonFormField<int>(
              value: controller.goal,
              decoration: const InputDecoration(
                  labelText: 'Steps Goal', border: OutlineInputBorder()),
              onChanged: controller.updateGoal,
              items: const [
                DropdownMenuItem(
                  value: 1000,
                  child: Text('1000'),
                ),
                DropdownMenuItem(
                  value: 2000,
                  child: Text('2000'),
                ),
                DropdownMenuItem(
                  value: 3000,
                  child: Text('3000'),
                ),
                DropdownMenuItem(
                  value: 4000,
                  child: Text('4000'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
