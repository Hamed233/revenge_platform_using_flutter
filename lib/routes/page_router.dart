import 'package:flutter/material.dart';
import 'package:revenge_platform/screens/auth/login/login_screen.dart';
import 'package:revenge_platform/screens/auth/register/register_screen.dart';
import 'package:revenge_platform/screens/hire/category_hire_screen.dart';
import 'package:revenge_platform/screens/hire/hire_home_screen.dart';
import 'package:revenge_platform/screens/layout_of_app.dart';
import 'package:revenge_platform/screens/tasks/tasks_screen.dart';
import 'package:revenge_platform/screens/top/top_screen.dart';

import 'page_path.dart';

class PageRouter {
  final RouteObserver<PageRoute> routeObserver;

  PageRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PagePath.splashScreen:
        // return _buildRoute(settings, SplashPage());
      case PagePath.onBoardScreen:
        // return _buildRoute(settings, OnBoardPage())
      case PagePath.homeScreen:
        return _buildRoute(settings, AppLayout());
      case PagePath.notificationScreen:
        // return _buildRoute(settings, NotificationScreen(bundle: args as ArgumentBundle));
      case PagePath.tasksScreen:
        return _buildRoute(settings, TasksScreen());
      case PagePath.topScreen:
        return _buildRoute(settings, const TopScreen());
      case PagePath.hireScreen:
        return _buildRoute(settings, HireHomeScreen());
      case PagePath.loginScreen:
        return _buildRoute(settings, LoginScreen());
      case PagePath.registerScreen:
        return _buildRoute(settings, RegisterScreen());
      case PagePath.searchScreen:
        // return _buildRoute(
        //   settings,
        //   SearchScreen(
        //     bundle: args as ArgumentBundle,
        //   ),
        // );      
      default:
        return _errorRoute();
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
