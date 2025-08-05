// models/artwork_model.dart
class ArtworkModel {
  final int id;
  final String title;
  final String artistName;
  final String imagePath;
  final String description;
  final String category;

  ArtworkModel({
    required this.id,
    required this.title,
    required this.artistName,
    required this.imagePath,
    required this.description,
    required this.category,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    return ArtworkModel(
      id: json['id'],
      title: json['title'],
      artistName: json['artistName'],
      imagePath: json['imagePath'],
      description: json['description'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artistName': artistName,
      'imagePath': imagePath,
      'description': description,
      'category': category,
    };
  }
}
