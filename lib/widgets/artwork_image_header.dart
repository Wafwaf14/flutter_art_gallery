// widgets/artwork_image_header.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/widgets/artwork_scrollable_view.dart'; // للـ ImageDimensions

class ArtworkImageHeader extends StatelessWidget {
  final ArtworkModel artwork;
  final ImageDimensions imageDimensions;
  final double progress;
  final double screenWidth;

  const ArtworkImageHeader({
    Key? key,
    required this.artwork,
    required this.imageDimensions,
    required this.progress,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: (screenWidth - imageDimensions.width) / 2,
      child: Transform.scale(
        scale: imageDimensions.scale,
        child: Container(
          width: imageDimensions.width,
          height: imageDimensions.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20 * (1 - progress)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2 * progress),
                blurRadius: 20 * progress,
                spreadRadius: 0,
                offset: Offset(0, 10 * progress),
              ),
            ],
          ),
          child: ClipRect(
            child: FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20 * (1 - progress)),
                child: _buildArtworkImage(),
              ),
            ),
          ),
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
}