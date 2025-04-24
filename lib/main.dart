import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rem_s_appliceation9/Screens/AccountPage.dart';
import 'package:rem_s_appliceation9/Screens/AccountPageUser.dart';
import 'package:rem_s_appliceation9/Screens/AvailableSubscriptionsPage.dart';
import 'package:rem_s_appliceation9/Screens/ChangePasswordPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/Screens/DriverInfoPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverOngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverSubscriptionsPage.dart';
import 'package:rem_s_appliceation9/Screens/MessagesHomePage.dart';
import 'package:rem_s_appliceation9/Screens/OngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/Requestedsubpage.dart';
import 'package:rem_s_appliceation9/Screens/ReviewPage.dart';
import 'package:rem_s_appliceation9/Screens/SettingsPage.dart';
import 'package:rem_s_appliceation9/Screens/Welcomepage.dart';
import 'package:rem_s_appliceation9/Screens/number_sub.dart';
import 'package:rem_s_appliceation9/Screens/subpage.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
//  مكتبة Firebase
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/services/UserProvider.dart';
import 'package:provider/provider.dart';

import 'Screens/number_sub.dart';
import 'routes/app_routes.dart';
import 'services/NotifProvider .dart';
import 'services/notif.dart';


var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  //الاشعارات 
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

 // NotificationService notificationService = NotificationService();
 // await notificationService.initialize();
 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),

      ],
      child: MyApp(),
    ),
  );
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // معالجة الإشعارات في الخلفية
  print("Handling a background message: ${message.messageId}");
    print('📩 [BG] Message received: ${message.notification?.title}');

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
          home: CreateSubscriptionPage(),

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
