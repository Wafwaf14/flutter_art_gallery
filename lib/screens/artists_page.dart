
// screens/artists_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/viewmodels/artists_viewmodel.dart';
import 'package:untitled3/widgets/artists_background_widget.dart';
import 'package:untitled3/widgets/artists_info_widget.dart';
import 'package:untitled3/widgets/rotating_circle_widget.dart';
import 'package:untitled3/widgets/side_dots_widget.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtistsViewModel(),
      child: const _ArtistsPageContent(),
    );
  }
}

class _ArtistsPageContent extends StatelessWidget {
  const _ArtistsPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistsViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            children: [
              // خلفية الصورة - بدون حركة
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
                    title: const Text(
                      'Artists',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // الدائرة الدوارة - ثابتة
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

              // معلومات الأسفل
              ArtistsInfoWidget(
                number: viewModel.currentNumber,
                artistName: viewModel.currentArtistName,
                date: viewModel.currentDate,
              ),
            ],
          ),
        );
      },
    );
  }
}