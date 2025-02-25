import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reem_s_application9/Screens/LoginPage.dart'; 
import 'package:firebase_core/firebase_core.dart';  //  مكتبة Firebase
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'darb',
          debugShowCheckedModeBanner: false,
          home: K0Screen(),
          
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
