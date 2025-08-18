// widgets/artwork_full_image_view.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';

class ArtworkFullImageView extends StatelessWidget {
  final ArtworkModel artwork;
  final VoidCallback onSwitchToScrollMode;
  final VoidCallback onClose;

  const ArtworkFullImageView({
    Key? key,
    required this.artwork,
    required this.onSwitchToScrollMode,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        // إذا كان السحب للأسفل
        if (details.primaryVelocity! > 300) {
          onSwitchToScrollMode();
        }
      },
      onTap: onClose,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Stack(
          children: [
            // الصورة الرئيسية
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _buildArtworkImage(),
            ),
            
            // مؤشر السحب للأسفل
            _buildSwipeIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildArtworkImage() {
    return artwork.imagePath.isNotEmpty
        ? Image.asset(
            artwork.imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorPlaceholder();
            },
          )
        : _buildErrorPlaceholder();
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 80,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSwipeIndicator() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Column(
        children: [
         
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white.withOpacity(0.7),
            size: 24,
          ),
        ],
      ),
    );
  }
}