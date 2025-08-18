// screens/artist_artworks_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/widgets/artists_background_widget.dart';
import 'package:untitled3/widgets/rotating_circle_widget.dart';
import 'package:untitled3/widgets/side_dots_widget.dart';
import 'package:untitled3/viewmodels/artist_artworks_viewmodel.dart';

class ArtistArtworksPage extends StatelessWidget {
  final ArtistModel artist;

  const ArtistArtworksPage({
    Key? key,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtistArtworksViewModel(artist),
      child: _ArtistArtworksPageContent(artist: artist),
    );
  }
}

class _ArtistArtworksPageContent extends StatelessWidget {
  final ArtistModel artist;

  const _ArtistArtworksPageContent({
    Key? key,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistArtworksViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            children: [
              // خلفية ديناميكية
              ArtistsBackgroundWidget(
                imagePath: viewModel.currentArtwork?.imagePath ?? '',
              ),

              // AppBar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(
                      artist.name,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 7, 7, 7),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // الدائرة الدوارة
              Positioned(
                top: MediaQuery.of(context).size.height * 0.6,
                left: 0,
                right: 0,
                child: RotatingCircleWidget(
                  rotation: viewModel.rotation,
                  onPanStart: () {},
                  onPanUpdate: (details) {
                    final center = Offset(
                      MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height * 0.6 + 60,
                    );
                    if (!viewModel.isDragging) {
                      viewModel.startDragging(center, details.globalPosition);
                    } else {
                      viewModel.updateRotation(center, details.globalPosition);
                    }
                  },
                  onPanEnd: (details) {
                    viewModel.stopDragging();
                  },
                ),
              ),

              // النقاط الجانبية
              const SideDotsWidget(),

              // معلومات العمل الفني
              Positioned(
                bottom: 120,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    // بطاقة معلومات العمل
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Text(
                        viewModel.currentArtwork?.title ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // معلومات إضافية
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Work ${viewModel.currentIndex + 1} of ${artist.artworks.length}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            viewModel.currentArtwork?.category ?? '',
                            style: TextStyle(
                              color: Colors.amber.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // معلومات الفنان في الأعلى
            ],
          ),
        );
      },
    );
  }
}