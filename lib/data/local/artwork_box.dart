// lib/data/local/artwork_box.dart
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/artwork.dart';

class ArtworkBox {
  static const String boxName = "artworks_box";

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ArtworkAdapter());
    await Hive.openBox<Artwork>(boxName);
  }

  static Box<Artwork> get box => Hive.box<Artwork>(boxName);
}
