// widgets/artwork_content_section.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/widgets/artwork_info_card.dart';
import 'package:untitled3/widgets/artwork_description.dart';
import 'package:untitled3/widgets/swipe_up_indicator.dart';

class ArtworkContentSection extends StatelessWidget {
  final ArtworkModel artwork;
  final double imageHeight;
  final double progress;

  const ArtworkContentSection({
    Key? key,
    required this.artwork,
    required this.imageHeight,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: imageHeight + 20,
      left: 0,
      right: 0,
      bottom: 0,
      child: Transform.translate(
        offset: Offset(0, 50 * (1 - progress)), // slide up effect
        child: Opacity(
          opacity: progress,
          child: Container(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // معلومات العمل الأساسية
                  ArtworkInfoCard(artwork: artwork),
                  
                  const SizedBox(height: 24),
                  
                  // خط فاصل
                  _buildDivider(),
                  
                  const SizedBox(height: 24),
                  
                  // وصف العمل
                  const ArtworkDescription(),
                  
                  const SizedBox(height: 32),
                  
                  // مؤشر السحب للأعلى للإغلاق
                  const SwipeUpIndicator(),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: 60,
      color: Colors.grey[300],
    );
  }
}