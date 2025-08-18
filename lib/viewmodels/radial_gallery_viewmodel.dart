// viewmodels/radial_gallery_viewmodel.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadialGalleryViewModel extends ChangeNotifier {
  // Sample data - replace with your actual data
  final List<Map<String, dynamic>> _artworks = [
    {
      'id': 120,
      'artistName': 'Khristina Galina',
      'date': 'January 2020',
      'title': 'Looking Glass',
      'imagePath': 'assets/artworks/portrait1.jpg',
    },
    {
      'id': 121,
      'artistName': 'Alessandro Volta',
      'date': 'March 2020',
      'title': 'Digital Dreams',
      'imagePath': 'assets/artworks/portrait2.jpg',
    },
    {
      'id': 122,
      'artistName': 'Maria Santos',
      'date': 'June 2020',
      'title': 'Abstract Mind',
      'imagePath': 'assets/artworks/portrait3.jpg',
    },
    {
      'id': 123,
      'artistName': 'David Chen',
      'date': 'September 2020',
      'title': 'Modern Vision',
      'imagePath': 'assets/artworks/portrait4.jpg',
    },
    {
      'id': 124,
      'artistName': 'Sofia Rodriguez',
      'date': 'December 2020',
      'title': 'Creative Soul',
      'imagePath': 'assets/artworks/portrait5.jpg',
    },
  ];

  int _currentIndex = 0;
  double _rotation = 0.0;
  bool _isDragging = false;
  double _lastAngle = 0.0;

  // Getters
  List<Map<String, dynamic>> get artworks => _artworks;
  int get currentIndex => _currentIndex;
  double get rotation => _rotation;
  bool get isDragging => _isDragging;
  
  Map<String, dynamic> get currentArtwork => _artworks[_currentIndex];
  int get currentId => currentArtwork['id'];
  String get currentArtistName => currentArtwork['artistName'];
  String get currentDate => currentArtwork['date'];
  String get currentTitle => currentArtwork['title'];
  String get currentImagePath => currentArtwork['imagePath'];

  // Calculate angle from center point to touch point
  double _calculateAngle(Offset center, Offset point) {
    final dx = point.dx - center.dx;
    final dy = point.dy - center.dy;
    return math.atan2(dy, dx) * (180 / math.pi);
  }

  // Start dragging the radial dial
  void startDragging(Offset center, Offset point) {
    _isDragging = true;
    _lastAngle = _calculateAngle(center, point);
    notifyListeners();
  }

  // Update rotation and artwork based on drag
  void updateRotation(Offset center, Offset point) {
    if (!_isDragging) return;

    final currentAngle = _calculateAngle(center, point);
    double angleDiff = currentAngle - _lastAngle;

    // Handle angle wraparound
    if (angleDiff > 180) angleDiff -= 360;
    if (angleDiff < -180) angleDiff += 360;

    _rotation += angleDiff;

    // Calculate which artwork should be shown based on rotation
    final normalizedRotation = ((_rotation % 360) + 360) % 360;
    final newIndex = (normalizedRotation / (360 / _artworks.length)).floor() % _artworks.length;
    
    if (newIndex != _currentIndex) {
      _currentIndex = newIndex;
    }

    _lastAngle = currentAngle;
    notifyListeners();
  }

  // Stop dragging
  void stopDragging() {
    _isDragging = false;
    notifyListeners();
  }

  // Navigate to next artwork
  void nextArtwork() {
    _currentIndex = (_currentIndex + 1) % _artworks.length;
    _rotation = (_currentIndex * (360 / _artworks.length));
    notifyListeners();
  }

  // Navigate to previous artwork
  void previousArtwork() {
    _currentIndex = (_currentIndex - 1 + _artworks.length) % _artworks.length;
    _rotation = (_currentIndex * (360 / _artworks.length));
    notifyListeners();
  }

  // Jump to specific artwork
  void selectArtwork(int index) {
    if (index >= 0 && index < _artworks.length) {
      _currentIndex = index;
      _rotation = (_currentIndex * (360 / _artworks.length));
      notifyListeners();
    }
  }

  // Add new artwork (for future expansion)
  void addArtwork(Map<String, dynamic> artwork) {
    _artworks.add(artwork);
    notifyListeners();
  }

  // Remove artwork
  void removeArtwork(int index) {
    if (index >= 0 && index < _artworks.length && _artworks.length > 1) {
      _artworks.removeAt(index);
      if (_currentIndex >= _artworks.length) {
        _currentIndex = _artworks.length - 1;
      }
      notifyListeners();
    }
  }
}