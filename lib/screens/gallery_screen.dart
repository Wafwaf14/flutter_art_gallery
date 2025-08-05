// screens/gallery_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/screens/artists_page.dart';
import 'package:untitled3/viewmodels/gallery_viewmodel.dart';
import 'package:untitled3/widgets/artist_info_display.dart';
import 'package:untitled3/widgets/vertical_sticks_widget.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GalleryViewModel(),
      child: const _GalleryScreenContent(),
    );
  }
}

class _GalleryScreenContent extends StatelessWidget {
  const _GalleryScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Be one of us',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
              TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ArtistsPage()),
    );
  },
  child: const Text('Artists', style: TextStyle(color: Colors.white70)),
),
              const SizedBox(width: 20),
            ],
          ),
          drawer: null,
          body: Stack(
            children: [
              // Dynamic Background
              _buildDynamicBackground(viewModel.currentArtwork),
              
              // Main Content
              if (viewModel.isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                )
              else if (viewModel.errorMessage.isNotEmpty)
                _buildErrorWidget(viewModel)
              else
                Column(
                  children: [
                    const Spacer(),
                    
                    // Artist Name
                    ArtistInfoDisplay(
                      artistName: viewModel.currentArtistName,
                    ),
                    
                    // Vertical Sticks
                    VerticalSticksWidget(
                      artworks: viewModel.artworks,
                      currentIndex: viewModel.currentIndex,
                      onStickTapped: viewModel.selectArtwork,
                      onPrevious: viewModel.previousArtwork,
                      onNext: viewModel.nextArtwork,
                    ),
                    
                    const Spacer(),
                    
                    // Bottom Info
                 //   BottomInfoWidget(artwork: viewModel.currentArtwork),
                    
                    const SizedBox(height: 20),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDynamicBackground(ArtworkModel? artwork) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: Container(
        key: ValueKey(artwork?.id ?? 0),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Background Image
            if (artwork != null)
              Image.asset(
                artwork.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2C1810), Color(0xFF8B4513)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  );
                },
              )
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1a1a1a), Color(0xFF2d2d2d)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            
            // Dark Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(GalleryViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading gallery',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            viewModel.errorMessage,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: viewModel.loadArtworks,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}