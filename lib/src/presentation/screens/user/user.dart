import 'package:flutter/material.dart';
import 'package:todo/src/presentation/widgets/layout.dart';

class User extends StatelessWidget {
  const User({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(body: Center(child: Text('Hello user'),), floatingButton: null);
  }
}