import 'package:flutter/material.dart';
import 'package:todo/src/presentation/screens/category.dart';
import 'package:todo/src/presentation/screens/home/home.dart';
import 'package:todo/src/presentation/screens/initial.dart';
import 'package:todo/src/presentation/screens/user/user.dart';

class TodoRouter {
  ModalRoute onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const InitialScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const HomeScreen(),
        );
      case '/category':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CategoryScreen(),
        );
        case '/user':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => User(),
        );
      default:
        throw UnimplementedError('Route is not implemented');
    }
  }

  static void pushRoute(String route, BuildContext context) {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.name != route) {
      Navigator.of(context).pushNamed(route);
    }
  }
}
