import 'package:flutter/material.dart';
import 'package:todo/src/presentation/screens/category.dart';
import 'package:todo/src/presentation/screens/home.dart';
import 'package:todo/src/presentation/screens/initial.dart';

class TodoRouter {
  ModalRoute onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/initial':
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const InitialScreen());
      case '/':
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const HomeScreen());
      case '/category':
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const CategoryScreen());
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
