import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../settings/settings_service.dart';

class ActivitiesService {
  final _box = GetStorage();
  late ValueNotifier<int> goal;
  ActivitiesService() {
   goal= ValueNotifier(getGoal());
    _box.listenKey('goal', (value) {
      if (value != null && value is int) {
        goal.value = value;
      }
    });
  }

  int getGoal() => _box.read<int?>('goal') ?? 4000;
}
