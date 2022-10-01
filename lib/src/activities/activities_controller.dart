import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:rxdart/subjects.dart';

import 'activities_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class ActivitiesController with ChangeNotifier {
  ActivitiesController(this._activitiesService) {
    goal.addListener(
      () => mapStep(),
    );
    mapStep();
  }

  // Make SettingsService a private variable so it is not used directly.
  final ActivitiesService _activitiesService;

  ValueNotifier<int> get goal => _activitiesService.goal;
  Stream<StepCount> stepCountStream = Pedometer.stepCountStream;

  Stream<PedestrianStatus> get pedestrianStatusStream =>
      Pedometer.pedestrianStatusStream.asBroadcastStream();

  final BehaviorSubject<int> _stepSubject = BehaviorSubject.seeded(0);
  Stream<int> get stepsStream => _stepSubject.stream;
  ValueNotifier<double> stepsGoal = ValueNotifier(0);
  int steps = 0;

  void onStepCount(StepCount event) {
    /// Handle step count changed
    int steps = event.steps;
    this.steps = steps;
    DateTime timeStamp = event.timeStamp;
    mapStep(event);
    log(steps.toString());
    log(timeStamp.toIso8601String());
  }

  void mapStep([StepCount? event]) {
    // final totalSteps = await _activitiesService.fetchSteps();
    final totalSteps = event?.steps ?? steps;
    final value = (totalSteps / goal.value) * 100;
    if (value > 100) {
      stepsGoal.value = 100;
    }
    if (value < 0) {
      stepsGoal.value = 0;
    } else {
      stepsGoal.value = value;
    }
    _stepSubject.add(totalSteps);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    /// Handle status changed
    String status = event.status;
    DateTime timeStamp = event.timeStamp;
    log(status);
    log(timeStamp.toIso8601String());
  }

  void onPedestrianStatusError(error) {
    /// Handle the error
    log(error.toString());
  }

  void onStepCountError(error) {
    log(error.toString());
  }

  Future<void> initPlatformState() async {
    /// Init streams

    /// Listen to streams and handle errors
    stepCountStream
        .asBroadcastStream()
        .listen(onStepCount)
        .onError(onStepCountError);
    pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    // ...
  }
}
