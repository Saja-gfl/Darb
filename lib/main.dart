import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rem_s_appliceation9/Screens/AvailableSubscriptionsPage.dart';
import 'package:rem_s_appliceation9/Screens/ChatPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverInfoPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverOngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/LoginPage.dart';
import 'package:rem_s_appliceation9/Screens/OngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/Welcomepage.dart';
//  مكتبة Firebase
import 'package:rem_s_appliceation9/Screens/chatPageLDriver.dart';
import 'package:rem_s_appliceation9/Screens/number_sub.dart';
import 'package:rem_s_appliceation9/Screens/otp.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/services/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/Screens/subpage.dart';
import 'package:rem_s_appliceation9/Screens/DriverSelectionPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/Screens/DriverSubscriptionsPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverOngoingSubsPage.dart';

import 'Screens/ReviewPage.dart';
import 'routes/app_routes.dart';


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
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
          //initialRoute: AppRoutes.k0Screen, // المسار الابتدائي
         routes: AppRoutes.routes, // تسجيل جميع المسارات
          home: WelcomePage(),

          // initialRoute: AppRoutes.initialRoute,
          // routes: AppRoutes.routes,
          // builder: (context, child) {
          //   return MediaQuery(
          //     data: MediaQuery.of(context).copyWith(
          //       textScaler: TextScaler.linear(1.0),
          //     ),
          //     child: child!,
             );
          // },
      
      },
    );
  }
}
