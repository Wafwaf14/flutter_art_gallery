// viewmodels/gallery_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'package:untitled3/services/artwork_service.dart';

class GalleryViewModel extends ChangeNotifier {
  final ArtworkService _artworkService = ArtworkService();
  
  List<ArtworkModel> _artworks = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentIndex = 0;

  // Getters
  List<ArtworkModel> get artworks => _artworks;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get currentIndex => _currentIndex;
  
  ArtworkModel? get currentArtwork => 
      _artworks.isNotEmpty ? _artworks[_currentIndex] : null;

  String get currentArtistName => currentArtwork?.artistName ?? '';

  GalleryViewModel() {
    loadArtworks();
  }

  Future<void> loadArtworks() async {
    _setLoading(true);
    _setError('');
    
    try {
      _artworks = await _artworkService.getAllArtworks();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void nextArtwork() {
    if (_artworks.isNotEmpty) {
      _setCurrentIndex((_currentIndex + 1) % _artworks.length);
    }
  }

  void previousArtwork() {
    if (_artworks.isNotEmpty) {
      _setCurrentIndex((_currentIndex - 1 + _artworks.length) % _artworks.length);
    }
  }

  void selectArtwork(int index) {
    if (index >= 0 && index < _artworks.length) {
      _setCurrentIndex(index);
    }
  }

  void _setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }
}
