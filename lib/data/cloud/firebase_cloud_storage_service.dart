// lib/data/cloud/firebase_cloud_storage_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String folderName) async {
  final fileName = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = _storage.ref().child('$folderName/$fileName');

  print('📤 Uploading to path: $folderName/$fileName');

  final uploadTask = await ref.putFile(file);
  final url = await uploadTask.ref.getDownloadURL();

  print('🔗 File URL: $url');
  return url;
}

}
