// widgets/rotating_circle_widget.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingCircleWidget extends StatelessWidget {
  final double rotation;
  final VoidCallback onPanStart;
  final Function(DragUpdateDetails) onPanUpdate;
  final Function(DragEndDetails) onPanEnd;

  const RotatingCircleWidget({
    Key? key,
    required this.rotation,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) => onPanStart(),
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Transform.rotate(
        angle: rotation * (math.pi / 180),
        child: Container(
          width: 50,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.8),
              width: 1.5,
            ),
          ),
          child: ClipOval(
            child: Container(
            
              child: Stack(
                children: [
                  const Positioned(
                    top: 5,
                    left: 0,
                    right: 0,
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Positioned(
                    right: 150,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Positioned(
                    left:150,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  
                  const Center(
                    child: Text(
                      'RADIAL DIAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
