// widgets/artwork_info_card.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';

class ArtworkInfoCard extends StatelessWidget {
  final ArtworkModel artwork;

  const ArtworkInfoCard({
    Key? key,
    required this.artwork,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان العمل
        _buildArtworkTitle(),
        
        const SizedBox(height: 16),
        
        // اسم الفنان
        _buildArtistName(),
      ],
    );
  }

  Widget _buildArtworkTitle() {
    return Text(
      artwork.title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        height: 1.2,
      ),
    );
  }

  Widget _buildArtistName() {
    return Container(
  
      child: Text(
        'By ${artwork.artistName}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(1, 26, 105, 1),
        ),
      ),
    );
  }
}