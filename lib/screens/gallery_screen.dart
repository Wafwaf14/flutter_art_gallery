// screens/gallery_screen.dart - Updated Navigation
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transition_plus/transition_plus.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/screens/artists_list_page.dart';
import 'package:untitled3/screens/artist_detail_page.dart';
import 'package:untitled3/screens/simple_artist_registration.dart';
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
          extendBodyBehindAppBar: true, // مهم لجعل الخلفية تمتد خلف AppBar
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              // Registration Button with Animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      ScaleTransition1(
                        page: const SimpleArtistRegistrationPage(),
                        type: ScaleTrasitionTypes.top,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Be one of us',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 10),
              
              // Artists Button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    ScaleTransition1(
                      page: const ArtistsListPage(),
                      type: ScaleTrasitionTypes.top,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Artists',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 20),
            ],
          ),
          drawer: null,
          body: Stack(
            children: [
              // Dynamic Background with Animation
              _buildDynamicBackground(viewModel.currentArtwork),
              
              // Floating particles animation (optional)
              _buildFloatingParticles(),
              
              // Main Content
              if (viewModel.isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 7, 255, 172)),
                  ),
                )
              else if (viewModel.errorMessage.isNotEmpty)
                _buildErrorWidget(viewModel)
              else
                Column(
                  children: [
                    const Spacer(),
                    
                    // Artist Name - Clickable with enhanced animation
                    _buildAnimatedArtistInfo(context, viewModel),
                    
                    // Vertical Sticks - Updated to use new compact design
                    VerticalSticksWidget(
                      artworks: viewModel.artworks,
                      currentIndex: viewModel.currentIndex,
                      onStickTapped: viewModel.selectArtwork,
                      onPrevious: viewModel.previousArtwork,
                      onNext: viewModel.nextArtwork,
                    ),
                    
                    const Spacer(),
            
                    
                    const SizedBox(height: 20),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedArtistInfo(BuildContext context, GalleryViewModel viewModel) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        key: ValueKey(viewModel.currentArtwork?.id ?? 0),
        onTap: () {
          if (viewModel.currentArtwork != null) {
            // الانتقال لصفحة أعمال الفنان
            final artist = ArtDataService.getArtistByName(
              viewModel.currentArtwork!.artistName
            );
            if (artist != null) {
              Navigator.push(
                context,
                ScaleTransition1(
                  page: ArtistDetailPage(
                    artistName: artist.name,
                  ),
                  type: ScaleTrasitionTypes.top,
                ),
              );
            }
          }
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ArtistInfoDisplay(
                artistName: viewModel.currentArtistName,
              ),
              const SizedBox(width: 12),
             
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildFloatingParticles() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.5),
              radius: 1.5,
              colors: [
                const Color.fromARGB(255, 54, 129, 39).withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicBackground(ArtworkModel? artwork) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.1, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
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
            
            // Subtle animated grain effect
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 2.0,
                  colors: [
                    const Color.fromARGB(255, 218, 44, 44).withOpacity(0.05),
                    Colors.transparent,
                  ],
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
          const Text(
            'Error loading gallery',
            style: TextStyle(color: Colors.white, fontSize: 18),
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
              backgroundColor: const Color.fromARGB(255, 11, 47, 207),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.refresh, size: 50),
                SizedBox(width: 8),
                Text('Retry'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}