import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/bloc.dart';
import '../../models/routine.dart';

class UpComingRoutinePage extends StatelessWidget {
  final List<Color> colors = [
    Color(0xFF29ABE1),
    Color(0xFFF7911E),
    Colors.red,
    Colors.purple,
    Colors.green,
  ];

  final Random rnd = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Routines"),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: BlocBuilder<RoutineCubit, RoutineState>(
          builder: (context, state) {
            if (state is RoutineSuccess) {
              final upcoming = getUpcomingRoutine(state.routines);
              List<String> dates = upcoming.keys.toList();
              return ListView.builder(
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  List<RoutineModel> events = upcoming[dates[index]];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: colors[rnd.nextInt(colors.length)],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dates[index],
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: events.length,
                            itemBuilder: (context, itemIndex) {
                              final routine = events[itemIndex];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor: Colors.white,
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Text(
                                        routine.title,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Offstage();
          },
        ),
      ),
    );
  }

// gets all routine in each date
  Map<String, List<RoutineModel>> getUpcomingRoutine(List<RoutineModel> list) {
    Map<String, List<RoutineModel>> upcoming = {};

    for (RoutineModel routine in list) {
      var format = DateFormat("EEEE - MMMM d");
      final date =
          format.format(DateTime.fromMillisecondsSinceEpoch(routine.reminder));
      upcoming[date] =
          upcoming[date] != null ? [...upcoming[date], routine] : [routine];
    }
    return upcoming;
  }
}
