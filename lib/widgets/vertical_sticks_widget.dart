// widgets/vertical_sticks_widget.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/widgets/artwork_detail_popup.dart';

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
              onTap: () {
                onStickTapped(originalIndex);

                // فتحة الكتاب محسنة - التمدد الطولي أولاً ثم العرضي
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  barrierColor: Colors.black.withOpacity(0.7),
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: ArtworkDetailPopup(artwork: artwork),
                      ),
                    );
                  },
                  transitionBuilder: (context, animation, secondaryAnimation, child) {
                    final curved = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    );

                    return AnimatedBuilder(
                      animation: curved,
                      builder: (context, _) {
                        final p = curved.value;

                        // 60% الأولى: تمدد طولي أولاً (كأن الكتاب يفتح من الأسفل للأعلى)
                        const heightPhase = 0.60;
                        final heightFactor = p < heightPhase ? (p / heightPhase) : 1.0;
                        
                        // 40% الأخيرة: تمدد عرضي
                        final widthFactor = p < heightPhase
                            ? 0.25  // عرض صغير في البداية
                            : 0.25 + (0.75 * ((p - heightPhase) / (1 - heightPhase)));

                        // زووم سريع مع أوفرشوت: 0.90 → 1.05 → 1.00
                        double lerp(double a, double b, double t) => a + (b - a) * t;
                        final scale = (p < 0.5)
                            ? lerp(0.90, 1.05, p / 0.5)          // تكبير سريع مع أوفرشوت
                            : lerp(1.05, 1.00, (p - 0.5) / 0.5); // عودة سريعة

                        return Opacity(
                          opacity: p * 0.95 + 0.05, // opacity من 0.05 إلى 1.0
                          child: Align(
                            alignment: Alignment.center,
                            child: Transform.scale(
                              scale: scale,
                              child: ClipRect(
                                child: FractionallySizedBox(
                                  heightFactor: heightFactor.clamp(0.0, 1.0),
                                  widthFactor: widthFactor.clamp(0.0, 1.0),
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: _buildVerticalStick(artwork, isActive),
            );
          }).toList(),
        ),

        const SizedBox(height: 50),

        // Navigation Arrows and Info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavigationArrow(
              icon: Icons.keyboard_arrow_left,
              onPressed: onPrevious,
            ),
            const SizedBox(width: 40),
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
    const sticksToShow = 7;
    if (artworks.length <= sticksToShow) {
      return artworks;
    }

    int start = currentIndex - (sticksToShow ~/ 2);
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
      width: isActive ? 35 : 25,
      height: isActive ? 290 : 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isActive
                ? const Color.fromARGB(255, 255, 24, 24).withOpacity(0.6)
                : Colors.black.withOpacity(0.5),
            blurRadius: isActive ? 15 : 10,
            offset: const Offset(0, 10),
            spreadRadius: isActive ? 3 : 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            // الصورة الأساسية مع معالجة أفضل للأخطاء
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[800],
              child: artwork.imagePath.isNotEmpty
                  ? Image.asset(
                      artwork.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        print('خطأ في تحميل الصورة: ${artwork.imagePath}');
                        print('تفاصيل الخطأ: $error');
                        return _buildPlaceholderImage(artwork.title);
                      },
                    )
                  : _buildPlaceholderImage(artwork.title),
            ),
            
            // تدرج لوني للنشط
            if (isActive)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withOpacity(0.2),
                      Colors.orange.withOpacity(0.1),
                      Colors.transparent
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.3, 1.0],
                  ),
                ),
              ),
            
            // تدرج سفلي خفيف
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3)
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(String title) {
    return Container(
      color: Colors.grey[700],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_outlined,
            color: Colors.white54,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            title.length > 8 ? '${title.substring(0, 8)}...' : title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 8,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
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