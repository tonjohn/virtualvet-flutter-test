import 'package:flutter/material.dart';

import '../../../../models/routine.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';

class EmptyRoutine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              "You don't have any routine today.",
              textAlign: TextAlign.center,
              style: getTextTheme(context).subtitle1.copyWith(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              "Add a new routine for reminders",
              style: getSubtitle(context).copyWith(
                fontSize: 15.0,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayRoutineWidget extends StatelessWidget {
  final List<RoutineModel> routines;
  const TodayRoutineWidget({this.routines});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 16.0,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 10.0,
                backgroundColor: ColorUtils.accentColor,
                child: CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  routine.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
