// lib/models/artwork.dart
import 'package:hive/hive.dart';

part 'artwork.g.dart';

@HiveType(typeId: 0)
class Artwork extends HiveObject {
  @HiveField(0)
  String imagePath;

  Artwork({required this.imagePath});
}
