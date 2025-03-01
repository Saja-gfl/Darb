import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< Updated upstream
import 'package:reem_s_application9/Screens/DriverHomePage.dart';
//import 'package:firebase_core/firebase_core.dart'; //  مكتبة Firebase
=======
import 'package:reem_s_application9/Screens/LoginPage.dart'; 
import 'package:firebase_core/firebase_core.dart';  //  مكتبة Firebase
>>>>>>> Stashed changes
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< Updated upstream
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp();
=======
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
          home: DriverHomePage(),

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
=======
          home: K0Screen(),
>>>>>>> Stashed changes
        );
      },
    );
  }
}
