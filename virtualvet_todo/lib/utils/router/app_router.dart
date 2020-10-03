export 'routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static push({BuildContext context, Widget page}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static pushToLogin({BuildContext context, Widget page}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static pushNamed({BuildContext context, String page}) {
    Navigator.of(context).pushNamed(page);
  }

  static pushReplacementNamed({BuildContext context, String page}) {
    Navigator.of(context).pushReplacementNamed(page);
  }

  static pushReplacement({BuildContext context, Widget page}) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static pushAndRemoveUntil({BuildContext context, Widget page}) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  static pop({BuildContext context}) {
    Navigator.of(context).pop();
  }
}
