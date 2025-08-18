// widgets/artists_background_widget.dart
import 'package:flutter/material.dart';

class ArtistsBackgroundWidget extends StatelessWidget {
  final String imagePath;

  const ArtistsBackgroundWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
              const Color.fromARGB(0, 255, 4, 4),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
      ),
    );
  }
}