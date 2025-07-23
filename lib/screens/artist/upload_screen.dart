// lib/screens/artist/upload_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/upload_provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _file;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UploadProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Upload Artwork")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final picked = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (picked != null) {
                  setState(() {
                    _file = File(picked.path);
                  });
                }
              },
              child: Text("Pick Image"),
            ),
            if (_file != null) Image.file(_file!, height: 150),
            SizedBox(height: 20),
            provider.isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (_file != null) provider.uploadFile(_file!);
                    },
                    child: Text("Upload"),
                  ),

            if (provider.uploadedUrl != null)
              SelectableText(
                "✅ Uploaded:\n${provider.uploadedUrl}",
                style: TextStyle(fontSize: 16, color: Colors.green),
              )
            else
              Text(
                "⛔ No file uploaded yet",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
