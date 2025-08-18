// widgets/side_dots_widget.dart
import 'package:flutter/material.dart';

class SideDotsWidget extends StatelessWidget {
  const SideDotsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: MediaQuery.of(context).size.height / 2 - 50,
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}