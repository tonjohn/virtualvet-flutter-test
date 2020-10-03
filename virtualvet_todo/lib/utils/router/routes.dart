import 'package:flutter/material.dart';

import '../../views/screens/home/home_page.dart';
import '../../views/screens/new_routine/new_routine_page.dart';
import '../../views/screens/routine_page.dart';

class Routes {
  static const ROUTINEPAGE = '/routine';
  static const HOMEPAGE = '/';
  static const NEWROUTINEPAGE = "/newroutinepage";

  // routes of pages in the app
  static Map<String, Widget Function(BuildContext)> get getroutes => {
        ROUTINEPAGE: (context) => RoutinePage(),
        HOMEPAGE: (context) => HomePage(),
        NEWROUTINEPAGE: (context) => NewRoutinePage(),
      };
}
