import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ThemeData getContext(BuildContext context) => Theme.of(context);

TextTheme getTextTheme(BuildContext context) => Theme.of(context).textTheme;

TextStyle getSubtitle(BuildContext context) =>
    Theme.of(context).textTheme.subtitle1;

Size getScreenSize(BuildContext context) => MediaQuery.of(context).size;

double getScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

// get the current date
String getCurrentDate() {
  var format = DateFormat("EEEE d, MMM");
  var dateString = format.format(DateTime.now());
  return dateString;
}

// checks if the routine is today on the list
bool isRoutineToday(int date) {
  var format = DateFormat("EEEE d, MMM");

  if (format.format(DateTime.now()) ==
      format.format(DateTime.fromMillisecondsSinceEpoch(date))) {
    return true;
  }

  return false;
}
