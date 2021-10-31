import 'package:flutter/material.dart';
import 'package:todo/src/logic/model/todo_model.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todoModel;
  final void Function(bool?) checkBoxHandler;
  final VoidCallback onTapHandler;
  const TodoCard(
      {Key? key, required this.todoModel, required this.checkBoxHandler, required this.onTapHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  shape: const CircleBorder(),
                  side: BorderSide(color: Color(int.parse(todoModel.color!))),
                  value: todoModel.isCompleted,
                  onChanged: checkBoxHandler,
                  checkColor: Colors.white,
                  activeColor: Color(int.parse(todoModel.color!)),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  todoModel.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      decoration: todoModel.isCompleted
                          ? TextDecoration.lineThrough
                          : null),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
