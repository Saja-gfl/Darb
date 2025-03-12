import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart'; //  مكتبة Firebase
import 'package:rem_s_appliceation9/Screens/DriverInfoPage.dart';
import 'package:rem_s_appliceation9/Screens/RegistrationPage.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/presentation/sign_up_screen/sign_up.Dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'core/app_export.dart';
import 'Screens/FindDriverPage.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'darb',
          debugShowCheckedModeBanner: false,
          home: K1Screen(),

          // initialRoute: AppRoutes.initialRoute,
          // routes: AppRoutes.routes,
          // builder: (context, child) {
          //   return MediaQuery(
          //     data: MediaQuery.of(context).copyWith(
          //       textScaler: TextScaler.linear(1.0),
          //     ),
          //     child: child!,
          //   );
          // },
        );
      },
    );
  }
}
