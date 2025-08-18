// screens/artists_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/screens/artist_artworks_page.dart';
import 'package:transition_plus/transition_plus.dart';

class ArtistsListPage extends StatelessWidget {
  const ArtistsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final artists = ArtDataService.allArtists;

    // ألوان مطابقة للصورة المرسلة - موسعة لـ 9 فنانين
    final List<Color> cardColors = [
      const Color(0xFF3D5A5C), // أخضر داكن مزرق
      const Color(0xFFE85A4F), // أحمر برتقالي
      const Color(0xFF52A3A3), // أزرق مخضر
      const Color(0xFFE6B17A), // برتقالي فاتح
      const Color(0xFFD2691E), // برتقالي
      const Color(0xFFDCB239), // أصفر ذهبي
      const Color(0xFF2F4F4F), // رمادي أخضر داكن
      const Color(0xFFCD853F), // بني ذهبي
      const Color(0xFF8B4A6B), // بنفسجي داكن
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // خلفية فاتحة
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Artists',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: artists.isEmpty
          ? const Center(
              child: Text(
                'No artists found',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // scroll سلس
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: StaggeredGrid.count(
                  crossAxisCount: 2, // عمودين
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: artists.asMap().entries.map((entry) {
                    final index = entry.key;
                    final artist = entry.value;
                    
                    return StaggeredGridTile.count(
                      crossAxisCellCount: _getCrossAxisCount(index),
                      mainAxisCellCount: _getMainAxisCount(index),
                      child: _buildArtistTile(
                        context,
                        artist: artist,
                        color: cardColors[index % cardColors.length],
                        onTap: () {
                          Navigator.push(
                            context,
                            ScaleTransition1(
                              page: ArtistArtworksPage(artist: artist),
                              type: ScaleTrasitionTypes.center,
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }

  // تحديد عرض الخلية حسب الفهرس (مطابق للصورة)
  int _getCrossAxisCount(int index) {
    switch (index) {
      case 0:
        return 1; // نصف العرض (أول كارد)
      case 1:
        return 1; // نصف العرض (ثاني كارد)
      case 2:
        return 1; // عرض كامل (كارد عريض)
      case 3:
        return 2; // نصف العرض
      case 4:
        return 1; // نصف العرض
      default:
        return 1;
    }
  }

  // تحديد ارتفاع الخلية حسب الفهرس (مطابق للصورة)
  int _getMainAxisCount(int index) {
    switch (index) {
      case 0:
        return 1; 
      case 1:
        return 2; 
      case 2:
        return 1; 
      case 3:
        return 2; 
      case 4:
        return 2; 
      default:
        return 3;
    }
  }

  Widget _buildArtistTile(
    BuildContext context, {
    required ArtistModel artist,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // خلفية بصورة العمل الأول للفنان
            _buildTileBackground(artist),
            
            // تدرج لوني للوضوح
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    color.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            
            // محتوى الكارد
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // اسم الفنان
                  Text(
                    artist.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 3,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${artist.artworks.length} artworks',
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 6),
                  
                  // الجنسية وسنة الميلاد
                  Text(
                    '${artist.nationality} • ${artist.birthYear}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTileBackground(ArtistModel artist) {
    // استخدام أول عمل للفنان كخلفية
    if (artist.artworks.isNotEmpty && artist.artworks.first.imagePath.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          artist.artworks.first.imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
         // opacity: const AlwaysStoppedAnimation(0.4), // شفافية للوضوح
          errorBuilder: (context, error, stackTrace) {
            return _buildPatternBackground();
          },
        ),
      );
    }
    return _buildPatternBackground();
  }

  Widget _buildPatternBackground() {
    // نمط هندسي بسيط كخلفية بديلة
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}