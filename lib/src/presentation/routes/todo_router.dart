import 'package:flutter/material.dart';
import 'package:todo/src/presentation/screens/category.dart';
import 'package:todo/src/presentation/screens/home.dart';

class TodoRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
        case '/category':
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      default:
        throw UnimplementedError('Unknown error');
    }
  }
}
