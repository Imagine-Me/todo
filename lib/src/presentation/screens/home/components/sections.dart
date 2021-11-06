import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';
import 'package:todo/src/logic/bloc/user/user_bloc.dart';

List<Widget> topSection() {
  return [
    BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Text(
          'Hi ${state.name}',
          style: Theme.of(context).textTheme.headline2,
        );
      },
    ),
    const SizedBox(
      height: 10,
    ),
    Builder(builder: (context) {
      return Text(
        'CATEGORIES',
        style: Theme.of(context).textTheme.headline5,
      );
    }),
    const SizedBox(
      height: 10,
    )
  ];
}

List<Widget> middleSection() {
  return [
    const SizedBox(
      height: 10,
    ),
    BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        String filterString = '';
        if (state.categoryName != null) {
          filterString += '( Category: ${state.categoryName} )';
        }
        return Text(
          'TODOS $filterString',
          style: Theme.of(context).textTheme.headline5,
        );
      },
    ),
    const SizedBox(
      height: 5,
    ),
  ];
}
