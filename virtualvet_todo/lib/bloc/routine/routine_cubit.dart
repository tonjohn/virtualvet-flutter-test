import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../models/routine.dart';
import '../../utils/utils.dart';
import 'routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  RoutineCubit() : super(RoutineLoading());

// add routine to TOdo list
  void addRoutine(Map data) async {
    // open the hive box
    final box = await Hive.openBox(GlobalUtils.boxName);
    // gets all list of routines
    final currentRoutine = await box.get(GlobalUtils.routine);

    if (currentRoutine != null) {
      // add routine to current list of routine
      await box.put(GlobalUtils.routine, [...currentRoutine, data]);
    } else {
      // add routine to current list of routine
      await box.put(GlobalUtils.routine, [data]);
    }
    // gets the current routine
    getRoutine(message: "Routine added Successfully");
  }

  // call when the app opens
  void initializeAndGetAllRoutine() async {
    final box = await Hive.openBox(GlobalUtils.boxName);

    await automarkComplete(box);
    getRoutine(activeBox: box);
  }

  void getRoutine({final activeBox, String message}) async {
    // open the hive box
    final box = activeBox ?? await Hive.openBox(GlobalUtils.boxName);
    try {
      // gets all the save data from the cache
      final List list = await box.get(GlobalUtils.routine);
      List<RoutineModel> completedRoutineList = [];
      List<RoutineModel> activeRoutineList = [];

      if (list != null) {
        for (final routine in list) {
          if (routine['is_completed']) {
            if (completedRoutineList.length < 6) {
              completedRoutineList.add(RoutineModel.fromMap(routine));
            }
          } else {
            activeRoutineList.add(RoutineModel.fromMap(routine));
          }
        }

        // sort the completed routine list in order of recent
        completedRoutineList.sort((a, b) => b.reminder.compareTo(a.reminder));
        // sort the active routine list in order of recent
        activeRoutineList.sort((a, b) => a.reminder.compareTo(b.reminder));

        // return all routines
        return emit(
          RoutineSuccess(
            today: activeRoutineList.where((element) {
              return isRoutineToday(element.reminder);
            }).toList(),
            completed: completedRoutineList,
            routines: activeRoutineList,
            message: message ?? "",
          ),
        );
      }

      emit(RoutineSuccess(today: [], routines: [], completed: []));
    } catch (e) {
      emit(
        RoutineFailure(message: "Oops... Error Encountered"),
      );
    }
  }

// it marks the routine complete once the time and date elapsed
// similar to using scheduling in firebase that check data every minute
// set and perform operation
  automarkComplete(final activeBox) async {
    final box = activeBox ?? await Hive.openBox(GlobalUtils.boxName);
    List list = await box.get(GlobalUtils.routine);

    if (list != null) {
      for (int index = 0; index < list.length; index++) {
        final routine = list[index];
        if (routine['is_completed'] == false) {
          if (routine['reminder'] < DateTime.now().millisecondsSinceEpoch) {
            list[index]['is_completed'] = true;
          }
        }
      }
      // add routine to current list of routine
      await box.put(GlobalUtils.routine, list);
    }
  }
}
