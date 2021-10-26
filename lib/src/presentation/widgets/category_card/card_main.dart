import 'package:flutter/material.dart';

class CardMain extends StatelessWidget {
  const CardMain({Key? key, required this.color, required this.category})
      : super(key: key);
  final int color;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(color),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              category,
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
