import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../utils/router/app_router.dart';
import '../../utils/utils.dart';

class RoutinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routines"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: BlocBuilder<RoutineCubit, RoutineState>(
          builder: (context, state) {
            if (state is RoutineSuccess) {
              return ListView.separated(
                itemCount: state.routines.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  final routine = state.routines[index];
                  return SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          routine.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        Icon(Icons.reorder),
                      ],
                    ),
                  );
                },
              );
            }
            return Offstage();
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          backgroundColor: ColorUtils.blueColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () => AppRouter.pushNamed(
            context: context,
            page: Routes.NEWROUTINEPAGE,
          ),
        ),
      ),
    );
  }
}
