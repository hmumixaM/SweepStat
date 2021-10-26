import 'package:flutter/material.dart';
import '../experiment/ExperimentSettings.dart';
import '../experiment/Experiment.dart';
import 'CoreState.dart';

class StateWidget extends StatefulWidget {
  final Widget child;

  const StateWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  CoreState state = CoreState(experiment: null, settings: null);

  void newSettings(ExperimentSettings settings) {
    final newState = state.copy(settings: settings);

    setState(() => state = newState);
  }

  void newExperiment(Experiment experiment) {
    final newState = state.copy(experiment: experiment);

    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) => BackEnd(
    child: widget.child,
    state: state,
    stateWidget: this,
  );
}

class BackEnd extends InheritedWidget {
  final CoreState state;
  final _StateWidgetState stateWidget;

  const BackEnd({
    Key key,
    @required Widget child,
    @required this.state,
    @required this.stateWidget,
  }) : super(key: key, child: child);

  static _StateWidgetState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<BackEnd>()
      .stateWidget;

  @override
  bool updateShouldNotify(BackEnd oldWidget) =>
      oldWidget.state != state;
}
