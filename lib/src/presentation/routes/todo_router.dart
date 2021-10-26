import 'package:flutter/material.dart';
import 'package:todo/src/presentation/screens/home.dart';

class TodoRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        throw UnimplementedError('Unknown error');
    }
  }
}
