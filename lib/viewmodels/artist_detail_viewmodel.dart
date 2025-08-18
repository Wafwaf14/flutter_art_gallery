// viewmodels/artist_detail_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/services/artwork_service.dart';
import 'dart:math' as math;

class ArtistDetailViewModel extends ChangeNotifier {
  final String artistName;
  final ArtworkService _artworkService = ArtworkService();
  
  List<ArtworkModel> _artworks = [];
  bool _isLoading = true;
  int _currentImageIndex = 0;
  double _rotation = 0.0;
  bool _isDragging = false;
  double _lastAngle = 0.0;

  ArtistDetailViewModel(this.artistName) {
    _loadArtistArtworks();
  }

  // Getters
  List<ArtworkModel> get artworks => _artworks;
  bool get isLoading => _isLoading;
  int get currentImageIndex => _currentImageIndex;
  double get rotation => _rotation;
  bool get isDragging => _isDragging;
  
  String get currentImage => 
      _artworks.isNotEmpty ? _artworks[_currentImageIndex].imagePath : '';
  
  String get currentArtworkTitle => 
      _artworks.isNotEmpty ? _artworks[_currentImageIndex].title : '';
  
  String get currentDate => 
      '${DateTime.now().year - (_currentImageIndex % 5)}'; // Mock date logic
  
  int get currentNumber => _currentImageIndex + 1;

  Future<void> _loadArtistArtworks() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final allArtworks = await _artworkService.getAllArtworks();
      _artworks = allArtworks.where((artwork) => 
          artwork.artistName.toLowerCase() == artistName.toLowerCase()).toList();
      
      // If no artworks found for specific artist, create mock artworks
      if (_artworks.isEmpty) {
        _artworks = _createMockArtworksForArtist();
      }
    } catch (e) {
      _artworks = _createMockArtworksForArtist();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ArtworkModel> _createMockArtworksForArtist() {
    final mockImages = [
      'assets/artworks/sea.jpg',
      'assets/artworks/sunset.jpg',
      'assets/artworks/waves.jpg',
      'assets/artworks/mountains.jpg',
    ];

    final mockTitles = [
      'Ocean Dreams',
      'Sunset Reflections',
      'Wave Motion',
      'Mountain View',
      'Abstract Form',
      'Color Study'
    ];

    return List.generate(
      mockImages.length,
      (index) => ArtworkModel(
        id: index + 100,
        title: mockTitles[index % mockTitles.length],
        artistName: artistName,
        imagePath: mockImages[index % mockImages.length],
        description: 'Artwork by $artistName',
        category: 'Featured Work',
      ),
    );
  }

  double _calculateAngle(Offset center, Offset point) {
    final dx = point.dx - center.dx;
    final dy = point.dy - center.dy;
    return math.atan2(dy, dx) * (180 / math.pi);
  }

  void startDragging(Offset center, Offset point) {
    _isDragging = true;
    _lastAngle = _calculateAngle(center, point);
    notifyListeners();
  }

  void updateRotation(Offset center, Offset point) {
    if (!_isDragging || _artworks.isEmpty) return;

    final currentAngle = _calculateAngle(center, point);
    double angleDiff = currentAngle - _lastAngle;

    if (angleDiff > 180) angleDiff -= 360;
    if (angleDiff < -180) angleDiff += 360;

    _rotation += angleDiff;

    final normalizedRotation = ((_rotation % 360) + 360) % 360;
    final imageIndex = (normalizedRotation / (360 / _artworks.length)).floor() % _artworks.length;
    
    if (imageIndex != _currentImageIndex) {
      _currentImageIndex = imageIndex;
    }

    _lastAngle = currentAngle;
    notifyListeners();
  }

  void stopDragging() {
    _isDragging = false;
    notifyListeners();
  }
}