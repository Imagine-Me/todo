import 'package:flutter/material.dart';
import 'package:todo/src/database/database.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key, required this.onFloatingActionButtonPressed})
      : super(key: key);
  final void Function(BuildContext, TodosCompanion?) onFloatingActionButtonPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onFloatingActionButtonPressed(context, null),
      child: const Icon(Icons.add),
    );
  }
}
