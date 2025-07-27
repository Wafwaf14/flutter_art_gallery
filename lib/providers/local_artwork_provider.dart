// lib/providers/local_artwork_provider.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/artwork.dart';

class LocalArtworkProvider with ChangeNotifier {
  final _boxName = 'artworksBox';
  List<Artwork> savedArtworks = [];

  Future<void> init() async {
    final box = await Hive.openBox<Artwork>(_boxName);
    savedArtworks = box.values.toList();
    notifyListeners();
  }

  Future<void> saveArtwork(String path) async {
    final box = await Hive.openBox<Artwork>(_boxName);
    final artwork = Artwork(imagePath: path);
    await box.add(artwork);
    savedArtworks.add(artwork);
    notifyListeners();
  }
}
