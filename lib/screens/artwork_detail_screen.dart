// screens/artwork_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';

class ArtworkDetailScreen extends StatelessWidget {
  final ArtworkModel artwork;

  const ArtworkDetailScreen({
    Key? key,
    required this.artwork,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: artwork.imagePath.isNotEmpty
                  ? DecorationImage(
                      image: AssetImage(artwork.imagePath),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: artwork.imagePath.isEmpty ? Colors.grey[800] : null,
            ),
          ),
          
          // Dark Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Column(
              children: [
                // Back Button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                
                const Spacer(),
                
                // Artwork Info
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        artwork.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Artist Name
                      Text(
                        'by ${artwork.artistName}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}