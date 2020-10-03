import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc.dart';
import '../../../utils/router/app_router.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/custom_end_drawer.dart';
import '../second_page.dart';
import '../upcoming_routine_page.dart';
import 'widgets/completed_routine.dart';
import 'widgets/routine_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 1), (timer) {
      print(timer.tick);
      BlocProvider.of<RoutineCubit>(context).initializeAndGetAllRoutine();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<BottomAppBarCubit, BottomAppBarState>(
        builder: (context, state) {
          if (state is SelectedBarItem) {
            if (state.itemIndex == 0) {
              return Home();
            }
            if (state.itemIndex == 1) {
              return SecondPage();
            }
          }
          return Offstage();
        },
      ),
      endDrawer: CustomEndDrawer(),
      drawer: Drawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRouter.pushNamed(
          context: context,
          page: Routes.NEWROUTINEPAGE,
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Colors.white),
        elevation: 5.0,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class Home extends StatelessWidget {
  // border radius for the card
  final borderRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // current date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TODAY",
                  style: getSubtitle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
                Text(getCurrentDate()),
              ],
            ),

            const SizedBox(height: 20.0),

            // load routines
            BlocBuilder<RoutineCubit, RoutineState>(
              builder: (context, state) {
                if (state is RoutineLoading) {
                  return SizedBox(
                    height: getScreenHeight(context) * 0.6,
                    width: getScreenWidth(context),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is RoutineSuccess) {
                  return Column(
                    children: [
                      // current routine or add a new routine
                      SizedBox(
                        width: double.maxFinite,
                        child: Card(
                          elevation: 5.0,
                          shape: borderRadius,
                          margin: EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              state.today.isEmpty
                                  ? EmptyRoutine()
                                  : TodayRoutineWidget(
                                      routines: state.today,
                                    ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                child: Text(
                                  "Edit Routine",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {
                                  AppRouter.pushNamed(
                                    context: context,
                                    page: Routes.ROUTINEPAGE,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 21.0),

                      // Upcoming routines
                      SizedBox(
                        width: double.maxFinite,
                        child: InkWell(
                          child: Card(
                            elevation: 5.0,
                            shape: borderRadius,
                            margin: EdgeInsets.all(0.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon:
                                            Icon(Icons.calendar_today_outlined),
                                        onPressed: () {},
                                      ),
                                      Text(
                                        "UPCOMING",
                                        style: getSubtitle(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // navigate next button
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.navigate_next,
                                      size: 30.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () => AppRouter.push(
                            context: context,
                            page: UpComingRoutinePage(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30.0),
                      // Recently completed events section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recently Completed",
                            style: getSubtitle(context).copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.black45,
                              fontSize: 13.8,
                            ),
                          ),
                          Divider(height: 30.0),
                          // displays recent completed routines
                          CompletedRoutineWidget(list: state.completed),
                        ],
                      )
                    ],
                  );
                }
                return Offstage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
