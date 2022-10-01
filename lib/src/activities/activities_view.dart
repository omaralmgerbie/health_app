import 'package:flutter/material.dart';
import 'package:health_app/src/activities/activities_controller.dart';
import 'package:health_app/src/settings/settings_view.dart';
import 'package:pedometer/pedometer.dart';

import '../utility/loading_indecator.dart';

class ActivitiesView extends StatefulWidget {
  const ActivitiesView({super.key, required this.controller});

  static const routeName = '/activities';

  final ActivitiesController controller;

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  @override
  void initState() {
    super.initState();
    widget.controller.initPlatformState();
  }

  TextTheme get textTheme => Theme.of(context).textTheme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities Screen'),centerTitle: true,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SettingsView.routeName),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            StreamBuilder<int>(
                stream: widget.controller.stepsStream,
                builder: (context, snapshot) {
                  return CircularProgressBar(
                    valueNotifier: widget.controller.stepsGoal,
                    progressColors: const [
                      Colors.cyan,
                      Colors.deepPurpleAccent
                    ],
                    mergeMode: true,
                    animationDuration: 1,
                    size: 200,
                    onGetText: (double value) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${snapshot.data}',
                            textAlign: TextAlign.center,
                            style:  const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('/${widget.controller.goal.value}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white38
                                  : Colors.black38,
                            )),
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 25,
            ),
            StreamBuilder<StepCount>(
                stream: widget.controller.stepCountStream,
                builder: (context, snapshot) {
                  return Text(
                    'Detected Steps ${snapshot.data?.steps}',
                    style: textTheme.headline5,
                  );
                }),
            const SizedBox(
              height: 5,
            ),
            const Text('this number may be inacurate'),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<PedestrianStatus>(
                stream: widget.controller.pedestrianStatusStream,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Status: ${snapshot.data?.status ?? 'stopped'}',
                        style: textTheme.headline5,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(snapshot.data?.status == 'walking'
                          ? Icons.directions_walk
                          : Icons.emoji_people)
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
