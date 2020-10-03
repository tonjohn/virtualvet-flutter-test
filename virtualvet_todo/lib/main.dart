import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'bloc/bottom_appBar/bottom_appbar_cubit.dart';
import 'bloc/routine/routine_cubit.dart';
import 'utils/color_utils.dart';
import 'utils/local_database.dart';
import 'utils/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataBase.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RoutineCubit routineCubit = RoutineCubit();

  @override
  void initState() {
    super.initState();
    routineCubit.initializeAndGetAllRoutine();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey[50],
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => routineCubit, lazy: false),
        BlocProvider(create: (_) => BottomAppBarCubit()),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          title: 'Vetbable',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.grey[50],
            accentColor: ColorUtils.accentColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: "Montserrat",
          ),
          routes: Routes.getroutes,
        ),
      ),
    );
  }
}
