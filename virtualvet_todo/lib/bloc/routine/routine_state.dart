import 'package:equatable/equatable.dart';

import '../../models/routine.dart';

abstract class RoutineState extends Equatable {
  const RoutineState();
  @override
  List<Object> get props => [];
}

class RoutineLoading extends RoutineState {}

class RoutineSuccess extends RoutineState {
  final List<RoutineModel> today;
  final List<RoutineModel> routines;
  final List<RoutineModel> completed;
  final String message;

  const RoutineSuccess({
    this.today,
    this.completed,
    this.routines,
    this.message,
  });

  @override
  List<Object> get props => [today, routines, completed];
}

class RoutineFailure extends RoutineState {
  final String message;

  const RoutineFailure({this.message});
}
