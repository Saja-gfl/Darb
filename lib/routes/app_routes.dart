import 'package:flutter/material.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/map_screen/map_screen.dart';
import '../presentation/sign_screen/sign_screen.dart';
import '../presentation/signin_screen/signin_screen.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String homePage = '/home_page';

  static const String messagesPage = '/messages_page';

  static const String mapScreen = '/map_screen';

  static const String mapInitialPage = '/map_initial_page';

  static const String signinScreen = '/signin_screen';

  static const String signScreen = '/sign_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    mapScreen: (context) => MapScreen(),
    signinScreen: (context) => SigninScreen(),
    signScreen: (context) => SignScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => MapScreen()
  };
}
