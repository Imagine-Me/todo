import 'package:flutter/material.dart';

class LoaderItem extends StatefulWidget {
  const LoaderItem({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  State<LoaderItem> createState() => _LoaderItemState();
}

class _LoaderItemState extends State<LoaderItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.note_alt_outlined,
              color: widget.color,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget.color,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
