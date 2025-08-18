// widgets/artwork_scrollable_view.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/widgets/artwork_image_header.dart';
import 'package:untitled3/widgets/artwork_content_section.dart';

class ArtworkScrollableView extends StatelessWidget {
  final ArtworkModel artwork;
  final Animation<double> animation;
  final VoidCallback onClose;

  const ArtworkScrollableView({
    Key? key,
    required this.artwork,
    required this.animation,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value;
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        final targetImageHeight = screenHeight * 0.25;
        
        // حساب أبعاد الصورة مع حركة فتح الكتاب
        final imageDimensions = _calculateImageDimensions(
          progress, 
          screenHeight, 
          screenWidth, 
          targetImageHeight,
        );

        return GestureDetector(
          onVerticalDragEnd: (details) {
            // السحب للأعلى للإغلاق (حركة عكسية)
            if (details.primaryVelocity! < -300) {
              onClose();
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(progress),
            child: Stack(
              children: [
                // الصورة المتحركة
                ArtworkImageHeader(
                  artwork: artwork,
                  imageDimensions: imageDimensions,
                  progress: progress,
                  screenWidth: screenWidth,
                ),
                
                // المحتوى النصي
                ArtworkContentSection(
                  artwork: artwork,
                  imageHeight: imageDimensions.height,
                  progress: progress,
                ),
                
                // زر الإغلاق
                _buildCloseButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  ImageDimensions _calculateImageDimensions(
    double progress,
    double screenHeight,
    double screenWidth,
    double targetImageHeight,
  ) {
    // حركة فتح الكتاب للعرض: 60% الأولى للطول، 40% الأخيرة للعرض
    const heightPhase = 0.60;
    late double imageWidth;
    late double imageHeight;
    
    if (progress < heightPhase) {
      // المرحلة الأولى: تقليص الارتفاع
      final heightProgress = progress / heightPhase;
      imageHeight = screenHeight * 0.8 * (1 - heightProgress) + 
                   targetImageHeight * heightProgress;
      imageWidth = screenWidth * 0.9; // العرض ثابت
    } else {
      // المرحلة الثانية: توسيع العرض
      final widthProgress = (progress - heightPhase) / (1 - heightPhase);
      imageHeight = targetImageHeight; // الارتفاع ثابت عند 25%
      imageWidth = screenWidth * 0.9 * (1 - widthProgress) + 
                  screenWidth * widthProgress;
    }

    // تأثير زووم مع أوفرشوت عكسي (تصغير ثم عودة)
    double lerp(double a, double b, double t) => a + (b - a) * t;
    final scale = (progress < 0.5)
        ? lerp(1.00, 0.96, progress / 0.5)        // تصغير خفيف
        : lerp(0.96, 1.00, (progress - 0.5) / 0.5); // عودة للحجم الطبيعي

    return ImageDimensions(
      width: imageWidth,
      height: imageHeight,
      scale: scale,
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: 40,
      right: 20,
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class ImageDimensions {
  final double width;
  final double height;
  final double scale;

  const ImageDimensions({
    required this.width,
    required this.height,
    required this.scale,
  });
}