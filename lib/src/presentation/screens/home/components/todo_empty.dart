import 'package:flutter/material.dart';

class TodoEmpty extends StatelessWidget {
  const TodoEmpty({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Wow, such empty!',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}