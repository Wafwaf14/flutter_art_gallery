// screens/artist_registration_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/viewmodels/artist_registration_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ArtistRegistrationPage extends StatelessWidget {
  const ArtistRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtistRegistrationViewModel(),
      child: const _ArtistRegistrationContent(),
    );
  }
}

class _ArtistRegistrationContent extends StatelessWidget {
  const _ArtistRegistrationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistRegistrationViewModel>(
      builder: (context, viewModel, child) {
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
                    controller: viewModel.nameController,
                    label: 'Artist Name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),

                  // Bio
                  _buildTextField(
                    controller: viewModel.bioController,
                    label: 'Bio / Description',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),

                  // Location
                  _buildTextField(
                    controller: viewModel.locationController,
                    label: 'Location',
                    icon: Icons.location_on,
                  ),
                  const SizedBox(height: 20),

                  // Art Style
                  _buildTextField(
                    controller: viewModel.artStyleController,
                    label: 'Art Style / Category',
                    icon: Icons.palette,
                  ),
                  const SizedBox(height: 30),

                  // Upload Artworks Section
                  const Text(
                    'Upload Your Artworks',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Add Artwork Button
                  GestureDetector(
                    onTap: () => _showImagePickerDialog(context, viewModel),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.5),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              color: Colors.amber,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add Artwork',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Artworks Grid
                  if (viewModel.artworkImages.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: viewModel.artworkImages.length,
                      itemBuilder: (context, index) {
                        return _buildArtworkTile(context, viewModel, index);
                      },
                    ),

                  const SizedBox(height: 40),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: viewModel.canSubmit() 
                          ? () => _handleSubmit(context, viewModel)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        disabledBackgroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Join the Gallery',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
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

  Widget _buildArtworkTile(BuildContext context, ArtistRegistrationViewModel viewModel, int index) {
    final artwork = viewModel.artworkImages[index];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.file(
                File(artwork['path']),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[700],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                artwork['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => viewModel.removeArtwork(index),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context, ArtistRegistrationViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Colors.amber),
                title: const Text('Camera', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageWithTitle(context, viewModel, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.amber),
                title: const Text('Gallery', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageWithTitle(context, viewModel, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageWithTitle(BuildContext context, ArtistRegistrationViewModel viewModel, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );

      if (image != null && context.mounted) {
        final title = await _showTitleDialog(context, viewModel.artworkImages.length);
        
        if (title != null) {
          viewModel.addArtworkWithTitle(image.path, title);
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<String?> _showTitleDialog(BuildContext context, int currentArtworkCount) async {
    final titleController = TextEditingController(text: 'Artwork ${currentArtworkCount + 1}');
    String? result;

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Artwork Title',
          style: TextStyle(color: Colors.amber),
        ),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter artwork title',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            ),
            autofocus: true,
            maxLength: 50,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                result = title;
              }
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ],
      ),
    );

    titleController.dispose();
    return result;
  }

  void _handleSubmit(BuildContext context, ArtistRegistrationViewModel viewModel) {
    viewModel.submitRegistration();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Success!',
          style: TextStyle(color: Colors.amber),
        ),
        content: const Text(
          'Your artist profile has been created successfully!',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}