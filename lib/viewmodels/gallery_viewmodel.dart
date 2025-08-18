// viewmodels/gallery_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';

class GalleryViewModel extends ChangeNotifier {
  List<ArtworkModel> _artworks = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  String _errorMessage = '';

  // Getters
  List<ArtworkModel> get artworks => _artworks;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  
  ArtworkModel? get currentArtwork => 
      _artworks.isNotEmpty ? _artworks[_currentIndex] : null;
  
  String get currentArtistName => 
      currentArtwork?.artistName ?? 'Unknown Artist';

  GalleryViewModel() {
    loadArtworks();
  }

  void loadArtworks() {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // تحميل جميع الأعمال الفنية من الخدمة
      _artworks = ArtDataService.allArtworks;
      
      if (_artworks.isEmpty) {
        _errorMessage = 'No artworks found';
      }
    } catch (e) {
      _errorMessage = 'Error loading artworks: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // تحميل أعمال فنان معين
  void loadArtworksByArtist(String artistName) {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _artworks = ArtDataService.getArtworksByArtist(artistName);
      _currentIndex = 0; // العودة للعمل الأول
      
      if (_artworks.isEmpty) {
        _errorMessage = 'No artworks found for $artistName';
      }
    } catch (e) {
      _errorMessage = 'Error loading artworks: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectArtwork(int index) {
    if (index >= 0 && index < _artworks.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void nextArtwork() {
    if (_artworks.isNotEmpty) {
      _currentIndex = (_currentIndex + 1) % _artworks.length;
      notifyListeners();
    }
  }

  void previousArtwork() {
    if (_artworks.isNotEmpty) {
      _currentIndex = (_currentIndex - 1 + _artworks.length) % _artworks.length;
      notifyListeners();
    }
  }

  // إعادة تعيين إلى جميع الأعمال
  void resetToAllArtworks() {
    loadArtworks();
  }

  // البحث في الأعمال الفنية
  void searchArtworks(String query) {
    if (query.isEmpty) {
      loadArtworks();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final allArtworks = ArtDataService.allArtworks;
      _artworks = allArtworks.where((artwork) {
        return artwork.title.toLowerCase().contains(query.toLowerCase()) ||
               artwork.artistName.toLowerCase().contains(query.toLowerCase()) ||
               artwork.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
      
      _currentIndex = 0;
      
      if (_artworks.isEmpty) {
        _errorMessage = 'No artworks found matching "$query"';
      } else {
        _errorMessage = '';
      }
    } catch (e) {
      _errorMessage = 'Error searching artworks: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // تصفية حسب الفئة
  void filterByCategory(String category) {
    _isLoading = true;
    notifyListeners();

    try {
      final allArtworks = ArtDataService.allArtworks;
      if (category.toLowerCase() == 'all') {
        _artworks = allArtworks;
      } else {
        _artworks = allArtworks.where((artwork) {
          return artwork.category.toLowerCase() == category.toLowerCase();
        }).toList();
      }
      
      _currentIndex = 0;
      
      if (_artworks.isEmpty) {
        _errorMessage = 'No artworks found in category "$category"';
      } else {
        _errorMessage = '';
      }
    } catch (e) {
      _errorMessage = 'Error filtering artworks: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // الحصول على معلومات إحصائية
  Map<String, dynamic> getStatistics() {
    final allArtworks = ArtDataService.allArtworks;
    final allArtists = ArtDataService.allArtists;
    
    // حساب الفئات
    final categories = <String, int>{};
    for (var artwork in allArtworks) {
      categories[artwork.category] = (categories[artwork.category] ?? 0) + 1;
    }

    return {
      'totalArtworks': allArtworks.length,
      'totalArtists': allArtists.length,
      'categories': categories,
      'currentArtist': currentArtistName,
      'currentCategory': currentArtwork?.category,
    };
  }
}