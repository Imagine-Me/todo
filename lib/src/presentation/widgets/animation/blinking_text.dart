import 'package:flutter/material.dart';

class BlinkingText extends StatefulWidget {
  const BlinkingText({Key? key, required this.text}) : super(key: key);
  final Widget text;
  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(milliseconds: 500), vsync: this)
        ..repeat(reverse: true);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.text,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
