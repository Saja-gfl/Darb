import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:reem_s_application9/Screens/userhome_page/userhome_page.dart';
import 'core/app_export.dart';
import 'Screens/otp.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
          home: UserHomePage(),


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
