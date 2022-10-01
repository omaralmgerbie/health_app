import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/src/activities/activities_controller.dart';
import 'package:health_app/src/activities/activities_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final settingsController = SettingsController(SettingsService());
  final activitiesController = ActivitiesController(ActivitiesService());

  await settingsController.loadSettings();

  if (Platform.isAndroid) {
    await Permission.activityRecognition.request();
  }
  runApp(MyApp(
    settingsController: settingsController,
    activitiesController: activitiesController,
  ));
}
