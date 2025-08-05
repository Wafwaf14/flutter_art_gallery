// services;/artwork_service.dart
import 'package:untitled3/models/artwork_model.dart';

class ArtworkService {
  // Mock data - replace with your actual asset paths
  static List<Map<String, dynamic>> _mockData = [
    {
      'id': 1,
      'title': 'Ocean Voyage',
      'artistName': 'Maritime Artist',
      'imagePath': 'assets/artworks/sea.jpg',
      'description': 'A beautiful maritime scene with sailing ships',
      'category': 'Maritime'
    },
    {
      'id': 2,
      'title': 'Abstract Colors',
      'artistName': 'Modern Artist',
      'imagePath': 'assets/artworks/sunset.jpg',
      'description': 'Vibrant abstract composition',
      'category': 'Abstract'
    },
    {
      'id': 3,
      'title': 'Portrait Study',
      'artistName': 'Renaissance Master',
      'imagePath': 'assets/artworks/waves.jpg',
      'description': 'Classical portrait painting',
      'category': 'Portrait'
    },
    {
      'id': 4,
      'title': 'Landscape View',
      'artistName': 'Nature Painter',
      'imagePath': 'assets/artworks/mountains.jpg',
      'description': 'Serene landscape painting',
      'category': 'Landscape'
    },
    {
      'id': 5,
      'title': 'Still Life',
      'artistName': 'Classical Artist',
      'imagePath': 'assets/artworks/sea.jpg',
      'description': 'Traditional still life composition',
      'category': 'Still Life'
    },
    {
      'id': 6,
      'title': 'Modern Art',
      'artistName': 'Contemporary Artist',
      'imagePath': 'assets/artworks/waves.jpg',
      'description': 'Contemporary artistic expression',
      'category': 'Contemporary'
    },
  ];

  Future<List<ArtworkModel>> getAllArtworks() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      return _mockData.map((json) => ArtworkModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load artworks: $e');
    }
  }

  Future<ArtworkModel?> getArtworkById(int id) async {
    final artworks = await getAllArtworks();
    try {
      return artworks.firstWhere((artwork) => artwork.id == id);
    } catch (e) {
      return null;
    }
  }
}
