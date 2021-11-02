import 'package:flutter/material.dart';
import 'package:todo/src/constants/enum.dart';

void showCustomSnackbar(context, String title, SnackBarType type) {
  Color? backgroundColor;
  Color? textColor = Colors.white;
  switch (type) {
    case SnackBarType.error:
      backgroundColor = Colors.red;
      break;
    case SnackBarType.info:
      backgroundColor = Colors.yellow;
      textColor = Colors.black;
      break;
    case SnackBarType.primary:
      backgroundColor = Colors.blue;
      break;
    case SnackBarType.success:
      backgroundColor = Colors.green;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title, style: TextStyle(color: textColor)),
      duration: const Duration(milliseconds: 800),
      backgroundColor: backgroundColor,
    ),
  );
}
