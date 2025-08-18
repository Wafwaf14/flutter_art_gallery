// viewmodels/artist_registration_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class ArtistRegistrationViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController artStyleController = TextEditingController();
  
  final ImagePicker _imagePicker = ImagePicker();
  List<Map<String, dynamic>> _artworkImages = [];

  List<Map<String, dynamic>> get artworkImages => _artworkImages;

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    locationController.dispose();
    artStyleController.dispose();
    super.dispose();
  }

  bool canSubmit() {
    return nameController.text.trim().isNotEmpty &&
           bioController.text.trim().isNotEmpty &&
           locationController.text.trim().isNotEmpty &&
           artStyleController.text.trim().isNotEmpty;
           // Remove requirement for artworks to test the button
  }

  Future<String?> pickImagePath(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );

      return image?.path;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  void addArtworkWithTitle(String imagePath, String title) {
    _artworkImages.add({
      'path': imagePath,
      'title': title.isEmpty ? 'Artwork ${_artworkImages.length + 1}' : title,
      'timestamp': DateTime.now().toIso8601String(),
    });
    
    notifyListeners();
  }

  void removeArtwork(int index) {
    if (index >= 0 && index < _artworkImages.length) {
      _artworkImages.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> submitRegistration() async {
    if (!canSubmit()) return;

    try {
      final artistData = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'name': nameController.text,
        'bio': bioController.text,
        'location': locationController.text,
        'artStyle': artStyleController.text,
        'artworks': _artworkImages,
        'registrationDate': DateTime.now().toIso8601String(),
      };

      await _saveArtistLocally(artistData);
      _clearForm();
      
    } catch (e) {
      debugPrint('Error submitting registration: $e');
    }
  }

  Future<void> _saveArtistLocally(Map<String, dynamic> artistData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Get existing artists
      final existingArtistsJson = prefs.getString('registered_artists') ?? '[]';
      final List<dynamic> existingArtists = json.decode(existingArtistsJson);
      
      // Add new artist
      existingArtists.add(artistData);
      
      // Save back to preferences
      await prefs.setString('registered_artists', json.encode(existingArtists));
      
      debugPrint('Artist saved successfully: ${artistData['name']}');
      
    } catch (e) {
      debugPrint('Error saving artist locally: $e');
    }
  }

  void _clearForm() {
    nameController.clear();
    bioController.clear();
    locationController.clear();
    artStyleController.clear();
    _artworkImages.clear();
    notifyListeners();
  }

  // Method to get all registered artists (for future use)
  static Future<List<Map<String, dynamic>>> getRegisteredArtists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final artistsJson = prefs.getString('registered_artists') ?? '[]';
      final List<dynamic> artistsList = json.decode(artistsJson);
      return artistsList.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('Error getting registered artists: $e');
      return [];
    }
  }

  // Method to update artwork title (to be called from UI)
  void updateArtworkTitle(int index, String newTitle) {
    if (index >= 0 && index < _artworkImages.length) {
      _artworkImages[index]['title'] = newTitle;
      notifyListeners();
    }
  }
}