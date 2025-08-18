// viewmodels/artist_artworks_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:untitled3/models/artwork_model.dart';
import 'dart:math' as math;

class ArtistArtworksViewModel extends ChangeNotifier {
  final ArtistModel artist;
  
  int _currentIndex = 0;
  double _rotation = 0.0;
  bool _isDragging = false;
  double _lastAngle = 0.0;

  ArtistArtworksViewModel(this.artist);

  // Getters
  List<ArtworkModel> get artworks => artist.artworks;
  int get currentIndex => _currentIndex;
  double get rotation => _rotation;
  bool get isDragging => _isDragging;
  
  ArtworkModel? get currentArtwork => 
      artworks.isNotEmpty ? artworks[_currentIndex] : null;

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
    if (!_isDragging) return;

    final currentAngle = _calculateAngle(center, point);
    double angleDiff = currentAngle - _lastAngle;

    if (angleDiff > 180) angleDiff -= 360;
    if (angleDiff < -180) angleDiff += 360;

    _rotation += angleDiff;

    // حساب الفهرس الجديد بناءً على الدوران
    final normalizedRotation = ((_rotation % 360) + 360) % 360;
    final newIndex = (normalizedRotation / (360 / artworks.length)).floor() % artworks.length;
    
    if (newIndex != _currentIndex) {
      _currentIndex = newIndex;
    }

    _lastAngle = currentAngle;
    notifyListeners();
  }

  void stopDragging() {
    _isDragging = false;
    notifyListeners();
  }

  void selectArtwork(int index) {
    if (index >= 0 && index < artworks.length) {
      _currentIndex = index;
      // تحديث الدوران ليتطابق مع الفهرس الجديد
      _rotation = (index * (360 / artworks.length));
      notifyListeners();
    }
  }

  void nextArtwork() {
    if (artworks.isNotEmpty) {
      _currentIndex = (_currentIndex + 1) % artworks.length;
      _rotation = (_currentIndex * (360 / artworks.length));
      notifyListeners();
    }
  }

  void previousArtwork() {
    if (artworks.isNotEmpty) {
      _currentIndex = (_currentIndex - 1 + artworks.length) % artworks.length;
      _rotation = (_currentIndex * (360 / artworks.length));
      notifyListeners();
    }
  }
}