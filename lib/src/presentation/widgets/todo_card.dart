import 'package:flutter/material.dart';
import 'package:todo/src/logic/model/todo_model.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todoModel;
  const TodoCard({Key? key, required this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            Checkbox(
              value: todoModel.isCompleted,
              onChanged: (bool? val) {},
              checkColor: Colors.white,
              activeColor: Color(int.parse(todoModel.color!)),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              todoModel.title,
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
