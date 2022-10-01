import 'package:flutter/material.dart';

import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode;

  late int _goal;

  ThemeMode get themeMode => _themeMode;
  int get goal => _goal;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _goal = await _settingsService.goal();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateGoal(int? newGoal) async {
    if (newGoal == null) return;

    if (newGoal == _goal) return;

    _goal = newGoal;

    notifyListeners();

    await _settingsService.updateGoal(newGoal);
  }
}
