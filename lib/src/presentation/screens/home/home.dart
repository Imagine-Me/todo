import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/database/database.dart';
import 'package:todo/src/logic/bloc/todo/todo_bloc.dart';
import 'package:todo/src/presentation/screens/home/components/add_category.dart';
import 'package:todo/src/presentation/screens/home/components/floating_button.dart';
import 'package:todo/src/presentation/screens/home/components/todo_empty.dart';
import 'package:todo/src/presentation/widgets/category_card/card_home.dart';
import 'package:todo/src/presentation/widgets/layout.dart';
import 'package:todo/src/presentation/widgets/todo_card.dart';
import 'package:todo/src/presentation/widgets/todo_form.dart';

import 'components/sections.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  onFloatingActionButtonPressed(context, TodosCompanion? todosCompanion) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return TodoForm(
          todosCompanion: todosCompanion,
        );
      },
    );
  }

  onCheckBoxClickHandler(bool? val, Todo entity, context) {
    final TodosCompanion todosCompanion = TodosCompanion(
      id: drift.Value(entity.id),
      title: drift.Value(entity.title),
      isCompleted: drift.Value(val ?? false),
      category: drift.Value(entity.category),
    );

    BlocProvider.of<TodoBloc>(context)
        .add(ToggleCompletedTodo(todosCompanion: todosCompanion));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: val != null && val
            ? const Text('Todo moved to completed')
            : const Text('Todo moved to uncompleted'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  onTodoDismissed(DismissDirection direction, Todo entity, context) {
    if (direction == DismissDirection.endToStart) {
      // Check if task already completed
      if (entity.isCompleted) {
        // DELETE TODO
        final TodosCompanion todosCompanion = TodosCompanion(
          id: drift.Value(entity.id),
          title: drift.Value(entity.title),
          isCompleted: drift.Value(entity.isCompleted),
          category: drift.Value(entity.category),
        );
        BlocProvider.of<TodoBloc>(context)
            .add(DeleteTodo(todosCompanion: todosCompanion));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Todo deleted',
            ),
            duration: Duration(milliseconds: 800),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // ADD TO COMPLETE
        onCheckBoxClickHandler(true, entity, context);
      }
    } else if (direction == DismissDirection.startToEnd) {
      onCheckBoxClickHandler(false, entity, context);
    }
  }

  onTodoTap(Todo entity, context) {
    final TodosCompanion todosCompanion = TodosCompanion(
      id: drift.Value(entity.id),
      title: drift.Value(entity.title),
      category: drift.Value(entity.category),
    );
    onFloatingActionButtonPressed(context, todosCompanion);
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...topSection(),
          SizedBox(
            height: 110,
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categoryCard.length,
                  itemBuilder: (context, index) {
                    return CardHome(categoryModel: state.categoryCard[index]);
                  },
                );
              },
            ),
          ),
          ...middleSection(),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
              if (state is TodoLoaded) {
                if (state.todos.isNotEmpty) {
                  return ListView.builder(
                    key: const Key('todo_list'),
                    itemCount: state.todoCard.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: state.todos[index].isCompleted
                            ? DismissDirection.horizontal
                            : DismissDirection.endToStart,
                        background: Container(color: Colors.greenAccent),
                        secondaryBackground: Container(
                          color: Colors.redAccent,
                        ),
                        child: TodoCard(
                          todoModel: state.todoCard[index],
                          onTapHandler: () =>
                              onTodoTap(state.todos[index], context),
                          checkBoxHandler: (bool? val) =>
                              onCheckBoxClickHandler(
                                  val, state.todos[index], context),
                        ),
                        onDismissed: (DismissDirection direction) =>
                            onTodoDismissed(
                                direction, state.todos[index], context),
                      );
                    },
                  );
                } else {
                  if (state.categoryState.categories.isEmpty) {
                    return const AddCategory();
                  }
                  return const TodoEmpty();
                }
              } else {
                return const Center(
                  child: Text('Loading....'),
                );
              }
            }),
          ),
        ],
      ),
      floatingButton: FloatingButton(onFloatingActionButtonPressed: onFloatingActionButtonPressed,),
    );
  }
}
