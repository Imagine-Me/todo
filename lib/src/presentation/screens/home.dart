import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/category_bloc.dart';
import 'package:todo/src/logic/bloc/todo_bloc.dart';
import 'package:todo/src/presentation/widgets/category_card/card_home.dart';
import 'package:todo/src/presentation/widgets/layout.dart';
import 'package:todo/src/presentation/widgets/todo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget floatingButton() {
    return Builder(builder: (context) {
      return FloatingActionButton(
        onPressed: () => onFloatingActionButtonPressed(context),
        child: const Icon(Icons.add),
      );
    });
  }

  onFloatingActionButtonPressed(context) {
    final TodosCompanion todosCompanion = TodosCompanion(
      category: drift.Value(1),
      title: drift.Value('First assignment'),
    );
    BlocProvider.of<TodoBloc>(context)
        .add(AddTodo(todosCompanion: todosCompanion));
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hi John',
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'CATEGORIES',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 100,
            child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categoryCard.length,
                itemBuilder: (context, index) {
                  return CardHome(categoryModel: state.categoryCard[index]);
                },
              );
            }),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'TODOS',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
              return ListView.builder(
                itemCount: state.todoCard.length,
                itemBuilder: (context, index) {
                  return TodoCard(todoModel: state.todoCard[index]);
                },
              );
            }),
          ),
        ],
      ),
      floatingButton: floatingButton(),
    );
  }
}
