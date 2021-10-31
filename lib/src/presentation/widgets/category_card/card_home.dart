import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/logic/bloc/todo_bloc.dart';
import 'package:todo/src/logic/model/catergory_model.dart';

class CardHome extends StatelessWidget {
  const CardHome({Key? key, required this.categoryModel}) : super(key: key);

  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
          border: categoryModel.isSelected
              ? Border.all(color: Theme.of(context).primaryColor)
              : null,
        ),
        width: 180,
        margin: const EdgeInsets.only(right: 10),
        child: InkWell(
          onTap: () {
            BlocProvider.of<TodoBloc>(context)
                .add(FilterTodo(keyword: '', category: categoryModel.id));
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${categoryModel.totalTasks} Tasks',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  categoryModel.category,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                LinearProgressIndicator(
                  value: categoryModel.progress,
                  backgroundColor: Colors.grey[100],
                  color: Color(categoryModel.color),
                )
              ],
            ),
          ),
        ));
  }
}
