// lib/providers/upload_provider.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../data/cloud/firebase_cloud_storage_service.dart';

class UploadProvider with ChangeNotifier {
  final _firebaseService = FirebaseCloudStorageService();

  bool isUploading = false;
  String? uploadedUrl;

 Future<void> uploadFile(File file) async {
  isUploading = true;
  notifyListeners();

  try {
    print('🔄 Starting upload...');
    uploadedUrl = await _firebaseService.uploadFile(file, "artworks");
    print('✅ Upload success: $uploadedUrl');
  } catch (e) {
    uploadedUrl = null;
    print('❌ Upload failed: $e');
  }

  isUploading = false;
  notifyListeners();
}

}
