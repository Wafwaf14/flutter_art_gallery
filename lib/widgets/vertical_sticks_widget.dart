// widgets/vertical_sticks_widget.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';

class VerticalSticksWidget extends StatelessWidget {
  final List<ArtworkModel> artworks;
  final int currentIndex;
  final Function(int) onStickTapped;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const VerticalSticksWidget({
    Key? key,
    required this.artworks,
    required this.currentIndex,
    required this.onStickTapped,
    required this.onPrevious,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (artworks.isEmpty) {
      return const Center(
        child: Text(
          'No artworks available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Show only 6 sticks at a time, centered around current index
    final visibleSticks = _getVisibleSticks();

    return Column(
      children: [
        // Vertical Sticks
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: visibleSticks.asMap().entries.map((entry) {
            final artwork = entry.value;
            final originalIndex = artworks.indexOf(artwork);
            final isActive = originalIndex == currentIndex;
            
            return GestureDetector(
              onTap: () => onStickTapped(originalIndex),
              child: _buildVerticalStick(artwork, isActive),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 30),
        
        // Navigation Arrows and Info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left Arrow
            _buildNavigationArrow(
              icon: Icons.keyboard_arrow_left,
              onPressed: onPrevious,
            ),
            
            const SizedBox(width: 40),
            
            // Artwork Info
            Column(
              children: [
                Text(
                  artworks[currentIndex].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${DateTime.now().year}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            
            const SizedBox(width: 40),
            
            // Right Arrow
            _buildNavigationArrow(
              icon: Icons.keyboard_arrow_right,
              onPressed: onNext,
            ),
          ],
        ),
      ],
    );
  }

  List<ArtworkModel> _getVisibleSticks() {
    const sticksToShow = 6;
    if (artworks.length <= sticksToShow) {
      return artworks;
    }

    // Calculate start index to center current artwork
    int start = currentIndex - (sticksToShow ~/ 2);
    
    // Ensure we don't go out of bounds
    if (start < 0) start = 0;
    if (start + sticksToShow > artworks.length) {
      start = artworks.length - sticksToShow;
    }

    return artworks.sublist(start, start + sticksToShow);
  }

  Widget _buildVerticalStick(ArtworkModel artwork, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 45 : 35,
      height: isActive ? 280 : 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isActive 
                ? const Color.fromARGB(255, 24, 86, 255).withOpacity(0.6)
                : Colors.black.withOpacity(0.5),
            blurRadius: isActive ? 10 : 10,
            offset: const Offset(0, 10),
            spreadRadius: isActive ? 2 : 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isActive 
                  ? [Colors.amber.withOpacity(0.9), Colors.orange.withOpacity(0.9)]
                  : [Colors.grey.withOpacity(0.8), Colors.grey[600]!.withOpacity(0.8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              // Artwork Image Placeholder
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                ),
                child: artwork.imagePath.isNotEmpty
                    ? Image.asset(
                        artwork.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage();
                        },
                      )
                    : _buildPlaceholderImage(),
              ),
              
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[700],
      child: const Center(
        child: Icon(
          Icons.image,
          color: Colors.white54,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildNavigationArrow({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        iconSize: 28,
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}