import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/src/presentation/widgets/animation/todo_loader/loader_item.dart';

class TodoLoader extends StatefulWidget {
  const TodoLoader({Key? key, required this.color}) : super(key: key);

  final Color color;
  @override
  _TodoLoaderState createState() => _TodoLoaderState();
}

class _TodoLoaderState extends State<TodoLoader> {
  late Timer future;
  int items = 0;
  @override
  void initState() {
    future = Timer.periodic(const Duration(seconds: 1), animateItems);
    super.initState();
  }

  @override
  void dispose() {
    future.cancel();
    super.dispose();
  }

  void animateItems(_) {
    setState(() {
      items = items == 3 ? 0 : items + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            items,
            (index) => LoaderItem(
                  color: widget.color,
                )),
      ),
    );
  }
}
