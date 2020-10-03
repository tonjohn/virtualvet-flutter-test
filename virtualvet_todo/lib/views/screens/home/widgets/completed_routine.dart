import 'package:flutter/material.dart';

import '../../../../models/routine.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';
import '../../../../utils/image_utils.dart';

class CompletedRoutineWidget extends StatelessWidget {
  final List<RoutineModel> list;
  const CompletedRoutineWidget({this.list});

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 200.0,
              child: Center(
                child: Text(
                  "No Routine",
                  style: getSubtitle(context).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          )
        : _RecentRoutine(list: list);
  }
}

class _RecentRoutine extends StatelessWidget {
  final List<RoutineModel> list;
  const _RecentRoutine({this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: list.map((routine) {
      return Column(
        children: [
          SizedBox(
            height: 60.0,
            child: ListTile(
              // image
              leading: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: AssetImage(ImageUtils.dog),
                  ),
                ),
              ),
              // routine title
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorUtils.blueColor,
                    radius: 4,
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
              // time
              subtitle: Row(
                children: [
                  const SizedBox(width: 24.0),
                  Icon(
                    Icons.alarm,
                    color: ColorUtils.textColor,
                    size: 13,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    "7 AM - 8 AM",
                    style: TextStyle(fontSize: 12.0),
                  )
                ],
              ),
            ),
          ),
          Divider(),
        ],
      );
    }).toList());
  }
}
