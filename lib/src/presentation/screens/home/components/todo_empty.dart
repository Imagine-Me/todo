import 'package:flutter/material.dart';
import 'package:todo/src/presentation/widgets/animation/todo_loader/todo_loader.dart';

class TodoEmpty extends StatelessWidget {
  const TodoEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Wow, such empty!',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 130,
            child: TodoLoader(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
