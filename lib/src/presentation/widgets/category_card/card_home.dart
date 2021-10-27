import 'package:flutter/material.dart';
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
        ),
        width: 180,
        margin: const EdgeInsets.only(right: 10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${categoryModel.totalTasks} Tasks',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Expanded(
                  child: Text(
                categoryModel.category,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              )),
              LinearProgressIndicator(
                value: .9,
                backgroundColor: Colors.grey,
                color: Color(categoryModel.color),
              )
            ],
          ),
        ));
  }
}
