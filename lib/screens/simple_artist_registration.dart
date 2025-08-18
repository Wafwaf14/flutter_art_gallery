// screens/simple_artist_registration_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SimpleArtistRegistrationPage extends StatefulWidget {
  const SimpleArtistRegistrationPage({Key? key}) : super(key: key);

  @override
  _SimpleArtistRegistrationPageState createState() => _SimpleArtistRegistrationPageState();
}

class _SimpleArtistRegistrationPageState extends State<SimpleArtistRegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController artStyleController = TextEditingController();
  
  bool isLoading = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Be One of Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Join Our Community of Artists',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share your art with the world and connect with fellow artists',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),

              // Artist Name
              _buildTextField(
                controller: nameController,
                label: 'Artist Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              // Bio
              _buildTextField(
                controller: bioController,
                label: 'Bio / Description',
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Location
              _buildTextField(
                controller: locationController,
                label: 'Location',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 20),

              // Art Style
              _buildTextField(
                controller: artStyleController,
                label: 'Art Style / Category',
                icon: Icons.palette,
              ),
              const SizedBox(height: 40),

              // Submit Button
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      : const Text(
                          'Join the Gallery',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Test Button (for debugging)
              Container(
                width: double.infinity,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    print('Test button pressed!');
                    print('Name: "${nameController.text}"');
                    print('Bio: "${bioController.text}"');
                    print('Location: "${locationController.text}"');
                    print('Art Style: "${artStyleController.text}"');
                    print('Can submit: ${canSubmit()}');
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Test: Can submit = ${canSubmit()}'),
                        backgroundColor: canSubmit() ? Colors.green : Colors.red,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.amber),
                  ),
                  child: const Text(
                    'Test Button (Debug)',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          setState(() {}); // Update UI when text changes
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.amber),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!canSubmit()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      print('Starting registration...');
      
      final artistData = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'name': nameController.text.trim(),
        'bio': bioController.text.trim(),
        'location': locationController.text.trim(),
        'artStyle': artStyleController.text.trim(),
        'registrationDate': DateTime.now().toIso8601String(),
      };

      await _saveArtistLocally(artistData);
      
      print('Registration saved successfully!');

      // Show success message
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Success! 🎉',
              style: TextStyle(color: Colors.amber),
            ),
            content: Text(
              'Welcome ${nameController.text}!\nYour artist profile has been created successfully!',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to previous screen
                },
                child: const Text(
                  'Great!',
                  style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error saving artist: $e');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
      
      print('Artist saved successfully: ${artistData['name']}');
      
    } catch (e) {
      print('Error saving artist locally: $e');
      throw Exception('Failed to save artist profile');
    }
  }
}