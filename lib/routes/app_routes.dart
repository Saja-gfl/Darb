import 'package:flutter/material.dart';
import '../Screens/app_navigation_screen/app_navigation_screen.dart';
import '../Screens/k0_screen/LoginPage.dart';
import '../Screens/k1_screen/RegistrationPage.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String k0Screen = '/k0_screen';

  static const String k1Screen = '/k1_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    k0Screen: (context) => K0Screen(),
    k1Screen: (context) => K1Screen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => K0Screen()
  };
}
