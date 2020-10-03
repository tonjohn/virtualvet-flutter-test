import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class CustomDialogs {
// show the snackbar to display message
  static void showSnackBar(final content) {
    showSimpleNotification(
      Text(
        content,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      background: Colors.red,
      duration: Duration(seconds: 5),
    );
  }

  // show the snackbar to display message
  static void showSuccessSnackBar(final content) {
    showSimpleNotification(
      Text(
        content,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      background: Colors.green,
      duration: Duration(seconds: 5),
    );
  }
}
