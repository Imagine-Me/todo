import 'package:flutter/material.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category/category_bloc.dart';

class PieChartModel {
  late final List<Todo> _todos;
  late final CategoryState _categoryState;
  List<Color> colorList = [];

  set todos(List<Todo> todos) {
    _todos = todos;
  }

  set category(CategoryState category) {
    _categoryState = category;
  }

  Map<String, double> get dataMap {
    Map<String, double> result = {};
    for (Category category in _categoryState.categories) {
      final todoList = _todos.where((e1) => e1.category == category.id);
      if (todoList.isNotEmpty) {
        result[category.category] = todoList.length.toDouble();
        colorList.add(Color(int.parse(category.color)));
      }
    }
    final completedList = _todos.where((element) => element.isCompleted);
    if (completedList.isNotEmpty) {
      result['Completed'] = completedList.length.toDouble();
      colorList.add(Colors.grey);
    }
    return result;
  }
}
