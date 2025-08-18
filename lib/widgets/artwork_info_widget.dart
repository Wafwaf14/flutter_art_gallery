// widgets/artwork_info_widget.dart
import 'package:flutter/material.dart';

class ArtworkInfoWidget extends StatelessWidget {
  final int id;
  final String artistName;
  final String date;

  const ArtworkInfoWidget({
    Key? key,
    required this.id,
    required this.artistName,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large ID number
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(0.0, 0.3), end: Offset.zero),
                ),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Text(
              '$id.',
              key: ValueKey(id),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Artist name
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(0.0, 0.3), end: Offset.zero),
                ),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Text(
              artistName,
              key: ValueKey(artistName),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Date
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(0.0, 0.3), end: Offset.zero),
                ),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Text(
              date,
              key: ValueKey(date),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}