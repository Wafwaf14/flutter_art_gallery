import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/local_artwork_provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _file;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalArtworkProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Upload Artwork Locally")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    _file = File(picked.path);
                  });
                }
              },
              child: const Text("Pick Image"),
            ),
            if (_file != null)
              Image.file(_file!, height: 150),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_file != null) {
                  await provider.saveArtwork(_file!.path);
                }
              },
              child: const Text("Save Locally"),
            ),
            const SizedBox(height: 10),
            if (provider.savedArtworks.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: provider.savedArtworks.length,
                  itemBuilder: (context, index) {
                    final artwork = provider.savedArtworks[index];
                    return ListTile(
                      leading: Image.file(File(artwork.imagePath), width: 40, height: 40),
                      title: Text(artwork.imagePath.split("/").last),
                    );
                  },
                ),
              )
            else
              const Text("⛔ No artworks saved yet", style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
