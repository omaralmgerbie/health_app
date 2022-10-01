import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService {
  final _box = GetStorage();
  Future<ThemeMode> themeMode() async => ThemeMode.values.firstWhere(
        (element) => _box.read<String?>('themeMode') == element.name,
        orElse: () => ThemeMode.system,
      );

  Future<void> updateThemeMode(ThemeMode theme) async {
    _box.write('themeMode', theme.name);
  }
  
  Future<int> goal() async =>  _box.read<int?>('goal')??4000 ;

  Future<void> updateGoal(int goalValue) async {
    _box.write('goal',goalValue);
  }
}
