// widgets/artist_info_display.dart
import 'package:flutter/material.dart';

class ArtistInfoDisplay extends StatelessWidget {
  final String artistName;

  const ArtistInfoDisplay({
    Key? key,
    required this.artistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Artist Name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            artistName,
            style: const TextStyle(
              color: Color.fromARGB(255, 2, 2, 2),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
              ],
    );
  }
}
