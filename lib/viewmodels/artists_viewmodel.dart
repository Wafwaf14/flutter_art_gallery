// viewmodels/artists_viewmodel.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArtistsViewModel extends ChangeNotifier {
  final List<String> _images = [
    'assets/artworks/mountains.jpg',
    'assets/artworks/sea.jpg',
    'assets/artworks/sunset.jpg',
    'assets/artworks/waves.jpg',
    'assets/artworks/sea.jpg',
  ];

  final List<String> _artistNames = [
    'Monica Bellucci',
    'Scarlett Johansson',
    'Emma Stone',
    'Margot Robbie',
    'Angelina Jolie',
  ];

  final List<String> _dates = [
    'January 2020',
    'March 2021',
    'June 2019',
    'September 2022',
    'December 2020',
  ];

  int _currentImageIndex = 0;
  double _rotation = 0.0;
 // double _imageOffset = 0.0;
  bool _isDragging = false;
  double _lastAngle = 0.0;

 // Getters
  List<String> get images => _images;
  int get currentImageIndex => _currentImageIndex;
  double get rotation => _rotation;
  bool get isDragging => _isDragging;
  String get currentImage => _images[_currentImageIndex];
  String get currentArtistName => _artistNames[_currentImageIndex];
  String get currentDate => _dates[_currentImageIndex];
  int get currentNumber => _currentImageIndex + 101;

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

    // تغيير الصور فقط بدون حركة عامودية
    final normalizedRotation = ((_rotation % 360) + 360) % 360;
    final imageIndex = (normalizedRotation / (360 / _images.length)).floor() % _images.length;
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