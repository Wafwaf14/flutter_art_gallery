// screens/artist_detail_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/viewmodels/artist_detail_viewmodel.dart';
import 'package:untitled3/widgets/artists_background_widget.dart';
import 'package:untitled3/widgets/artists_info_widget.dart';
import 'package:untitled3/widgets/rotating_circle_widget.dart';
import 'package:untitled3/widgets/side_dots_widget.dart';

class ArtistDetailPage extends StatelessWidget {
  final String artistName;
  
  const ArtistDetailPage({
    Key? key,
    required this.artistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtistDetailViewModel(artistName),
      child: _ArtistDetailPageContent(artistName: artistName),
    );
  }
}

class _ArtistDetailPageContent extends StatelessWidget {
  final String artistName;
  
  const _ArtistDetailPageContent({
    Key? key,
    required this.artistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistDetailViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          );
        }

        if (viewModel.artworks.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const Center(
              child: Text(
                'No artworks found for this artist',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              ArtistsBackgroundWidget(
                imagePath: viewModel.currentImage,
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
                      artistName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${viewModel.artworks.length} works',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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

              const SideDotsWidget(),

              ArtistsInfoWidget(
                number: viewModel.currentNumber,
                artistName: viewModel.currentArtworkTitle,
                date: viewModel.currentDate,
              ),
            ],
          ),
        );
      },
    );
  }
}