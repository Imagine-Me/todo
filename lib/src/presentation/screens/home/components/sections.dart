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

List<Widget> middleSection(VoidCallback onFilterSelected) {
  return [
    const SizedBox(
      height: 10,
    ),
    Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
        IconButton(
            key: const Key('home_filter_button'),
            onPressed: onFilterSelected,
            icon: const Icon(Icons.filter_list_sharp))
      ],
    ),
    const SizedBox(
      height: 5,
    ),
  ];
}
