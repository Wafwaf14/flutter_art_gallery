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

// نموذج بيانات الفنان
class ArtistModel {
  final String name;
  final String bio;
  final String profileImage;
  final List<ArtworkModel> artworks;
  final String birthYear;
  final String nationality;

  ArtistModel({
    required this.name,
    required this.bio,
    required this.profileImage,
    required this.artworks,
    required this.birthYear,
    required this.nationality,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      name: json['name'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      artworks: (json['artworks'] as List)
          .map((artwork) => ArtworkModel.fromJson(artwork))
          .toList(),
      birthYear: json['birthYear'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'profileImage': profileImage,
      'artworks': artworks.map((artwork) => artwork.toJson()).toList(),
      'birthYear': birthYear,
      'nationality': nationality,
    };
  }
}

// خدمة إدارة البيانات
class ArtDataService {
  static final List<ArtistModel> _artists = [
    ArtistModel(
      name: 'Monica Bellucci',
      bio: 'فنانة إيطالية معاصرة تتميز بأسلوبها الفريد في الرسم والنحت.',
      profileImage: 'assets/artworks/jap/3.jpg',
      birthYear: '1964',
      nationality: 'Italian',
      artworks: [
        ArtworkModel(
          id: 1,
          title: 'Mediterranean Dreams',
          artistName: 'Monica Bellucci',
          imagePath: 'assets/artworks/jap/1.jpg',
          description: 'لوحة تعبر عن جمال البحر المتوسط وألوانه الساحرة.',
          category: 'Oil Painting',
        ),
        ArtworkModel(
          id: 2,
          title: 'Roman Sunset',
          artistName: 'Monica Bellucci',
          imagePath: 'assets/artworks/jap/2.jpg',
          description: 'منظر طبيعي يجسد غروب الشمس فوق روما القديمة.',
          category: 'Acrylic',
        ),
        ArtworkModel(
          id: 3,
          title: 'Venice Reflections',
          artistName: 'Monica Bellucci',
          imagePath: 'assets/artworks/jap/3.jpg',
          description: 'انعكاسات مياه البندقية في لوحة مائية رائعة.',
          category: 'Watercolor',
        ),
        ArtworkModel(
          id: 4,
          title: 'Tuscan Hills',
          artistName: 'Monica Bellucci',
          imagePath: 'assets/artworks/jap/4.jpg',
          description: 'تلال توسكانا الخضراء في ربيع إيطاليا.',
          category: 'Mixed Media',
        ),
      ],
    ),
    ArtistModel(
      name: 'Scarlett Johansson',
      bio: 'فنانة أمريكية معاصرة تركز على الفن التجريدي والألوان الجريئة.',
      profileImage: 'assets/artworks/sketch/3.jpg',
      birthYear: '1984',
      nationality: 'American',
      artworks: [
        ArtworkModel(
          id: 5,
          title: 'New York Nights',
          artistName: 'Scarlett Johansson',
          imagePath: 'assets/artworks/sketch/1.jpg',
          description: 'أضواء مدينة نيويورك في الليل بألوان نيون جريئة.',
          category: 'Digital Art',
        ),
        ArtworkModel(
          id: 6,
          title: 'Abstract Emotions',
          artistName: 'Scarlett Johansson',
          imagePath: 'assets/artworks/sketch/2.jpg',
          description: 'تعبير تجريدي عن المشاعر الإنسانية المعقدة.',
          category: 'Abstract',
        ),
        ArtworkModel(
          id: 7,
          title: 'Urban Symphony',
          artistName: 'Scarlett Johansson',
          imagePath: 'assets/artworks/sketch/3.jpg',
          description: 'سيمفونية بصرية تجسد إيقاع المدينة الحديثة.',
          category: 'Mixed Media',
        ),
        ArtworkModel(
          id: 8,
          title: 'Color Burst',
          artistName: 'Scarlett Johansson',
          imagePath: 'assets/artworks/sketch/4.jpg',
          description: 'انفجار لوني يعبر عن الطاقة والحيوية.',
          category: 'Acrylic',
        ),
      ],
    ),
    ArtistModel(
      name: 'Emma Stone',
      bio: 'فنانة بريطانية تتخصص في الرسم الطبيعي والمناظر الخلابة.',
      profileImage: 'assets/artworks/pink/4.jpg',
      birthYear: '1988',
      nationality: 'British',
      artworks: [
        ArtworkModel(
          id: 9,
          title: 'English Countryside',
          artistName: 'Emma Stone',
          imagePath: 'assets/artworks/pink/1.jpg',
          description: 'الريف الإنجليزي في فصل الربيع مع الزهور البرية.',
          category: 'Oil Painting',
        ),
        ArtworkModel(
          id: 10,
          title: 'Misty Mountains',
          artistName: 'Emma Stone',
          imagePath: 'assets/artworks/pink/2.jpg',
          description: 'جبال ضبابية في الصباح الباكر مع الندى.',
          category: 'Watercolor',
        ),
        ArtworkModel(
          id: 11,
          title: 'Autumn Forest',
          artistName: 'Emma Stone',
          imagePath: 'assets/artworks/pink/3.jpg',
          description: 'غابة في فصل الخريف بألوانها الذهبية الدافئة.',
          category: 'Oil Painting',
        ),
        ArtworkModel(
          id: 12,
          title: 'Coastal Breeze',
          artistName: 'Emma Stone',
          imagePath: 'assets/artworks/pink/4.jpg',
          description: 'نسيم الساحل الإنجليزي مع الطيور البحرية.',
          category: 'Acrylic',
        ),
      ],
    ),
    ArtistModel(
      name: 'Margot Robbie',
      bio: 'فنانة أسترالية معاصرة تجمع بين الفن التقليدي والحديث.',
      profileImage: 'assets/artworks/line/1.jpg',
      birthYear: '1990',
      nationality: 'Australian',
      artworks: [
        ArtworkModel(
          id: 13,
          title: 'Outback Dreams',
          artistName: 'Margot Robbie',
          imagePath: 'assets/artworks/line/1.jpg',
          description: 'صحراء أستراليا النائية في ضوء الغسق الذهبي.',
          category: 'Oil Painting',
        ),
        ArtworkModel(
          id: 14,
          title: 'Sydney Harbor',
          artistName: 'Margot Robbie',
          imagePath: 'assets/artworks/line/2.jpg',
          description: 'ميناء سيدني مع دار الأوبرا الشهيرة.',
          category: 'Watercolor',
        ),
        ArtworkModel(
          id: 15,
          title: 'Coral Gardens',
          artistName: 'Margot Robbie',
          imagePath: 'assets/artworks/line/3.jpg',
          description: 'حدائق الشعاب المرجانية تحت الماء بألوان زاهية.',
          category: 'Mixed Media',
        ),
        ArtworkModel(
          id: 16,
          title: 'Kangaroo Valley',
          artistName: 'Margot Robbie',
          imagePath: 'assets/artworks/line/4.jpg',
          description: 'وادي الكنغر الأخضر في جنوب أستراليا.',
          category: 'Acrylic',
        ),
      ],
    ),
     ArtistModel(
      name: 'Natalie Portman',
      bio: 'فنانة أمريكية إسرائيلية تركز على الفن المفاهيمي والتركيبات الفنية.',
      profileImage: 'assets/artists/puzzel/3.jpg',
      birthYear: '1981',
      nationality: 'American',
      artworks: [
        ArtworkModel(
          id: 17,
          title: 'Desert Mirage',
          artistName: 'Natalie Portman',
          imagePath: 'assets/artworks/puzzel/1.jpg',
          description: 'سراب الصحراء وتأثيراته البصرية الخادعة.',
          category: 'Conceptual Art',
        ),
        ArtworkModel(
          id: 18,
          title: 'Urban Shadows',
          artistName: 'Natalie Portman',
          imagePath: 'assets/artworks/puzzel/2.jpg',
          description: 'ظلال المدينة في ساعات المساء الذهبية.',
          category: 'Photography',
        ),
        ArtworkModel(
          id: 19,
          title: 'Memory Fragments',
          artistName: 'Natalie Portman',
          imagePath: 'assets/artworks/puzzel/3.jpg',
          description: 'قطع من الذكريات مجمعة في تركيب فني معاصر.',
          category: 'Installation',
        ),
        ArtworkModel(
          id: 20,
          title: 'Ocean Depths',
          artistName: 'Natalie Portman',
          imagePath: 'assets/artworks/puzzel/4.jpg',
          description: 'أعماق المحيط وأسراره المخفية.',
          category: 'Mixed Media',
        ),
      ],
    ),
    ArtistModel(
      name: 'Charlize Theron',
      bio: 'فنانة جنوب أفريقية تعبر عن الثقافة الأفريقية من خلال الفن المعاصر.',
      profileImage: 'assets/artists/colors/3.jpg',
      birthYear: '1975',
      nationality: 'South African',
      artworks: [
        ArtworkModel(
          id: 21,
          title: 'African Sunrise',
          artistName: 'Charlize Theron',
          imagePath: 'assets/artworks/colors/1.jpg',
          description: 'شروق الشمس فوق سافانا أفريقيا بألوانه الدافئة.',
          category: 'Oil Painting',
        ),
        ArtworkModel(
          id: 22,
          title: 'Tribal Rhythms',
          artistName: 'Charlize Theron',
          imagePath: 'assets/artworks/colors/2.jpg',
          description: 'إيقاعات قبلية تتجسد في أشكال وألوان تجريدية.',
          category: 'Abstract',
        ),
        ArtworkModel(
          id: 23,
          title: 'Cape Town Bay',
          artistName: 'Charlize Theron',
          imagePath: 'assets/artworks/colors/3.jpg',
          description: 'خليج كيب تاون مع جبل تيبل في الخلفية.',
          category: 'Watercolor',
        ),
        ArtworkModel(
          id: 24,
          title: 'Wildlife Spirit',
          artistName: 'Charlize Theron',
          imagePath: 'assets/artworks/colors/4.jpg',
          description: 'روح الحيوانات البرية الأفريقية في تصوير معاصر.',
          category: 'Acrylic',
        ),
      ],
    ),
    ArtistModel(
      name: 'Anne Hathaway',
      bio: 'فنانة أمريكية تتخصص في الفن الرقمي والتصاميم التفاعية.',
      profileImage: 'assets/artists/abstract/1.jpg',
      birthYear: '1982',
      nationality: 'American',
      artworks: [
        ArtworkModel(
          id: 25,
          title: 'Digital Dreams',
          artistName: 'Anne Hathaway',
          imagePath: 'assets/artworks/abstract/1.jpg',
          description: 'أحلام رقمية تمزج بين الواقع والخيال.',
          category: 'Digital Art',
        ),
        ArtworkModel(
          id: 26,
          title: 'Cyber Garden',
          artistName: 'Anne Hathaway',
          imagePath: 'assets/artworks/abstract/2.jpg',
          description: 'حديقة إلكترونية تجمع بين الطبيعة والتكنولوجيا.',
          category: 'Interactive Art',
        ),
        ArtworkModel(
          id: 27,
          title: 'Virtual Reality',
          artistName: 'Anne Hathaway',
          imagePath: 'assets/artworks/abstract/3.jpg',
          description: 'استكشاف الواقع الافتراضي من خلال الفن البصري.',
          category: 'VR Art',
        ),
        ArtworkModel(
          id: 28,
          title: 'Pixel Poetry',
          artistName: 'Anne Hathaway',
          imagePath: 'assets/artworks/abstract/4.jpg',
          description: 'شعر مرئي مكون من وحدات البكسل والألوان الرقمية.',
          category: 'Digital Art',
        ),
      ],
    ),
    ArtistModel(
      name: 'Penélope Cruz',
      bio: 'فنانة إسبانية تعبر عن التراث الإسباني من خلال الفن الكلاسيكي المعاصر.',
      profileImage: 'assets/artists/phograph/1.jpg',
      birthYear: '1974',
      nationality: 'Spanish',
      artworks: [
        ArtworkModel(
          id: 29,
          title: 'Flamenco Soul',
          artistName: 'Penélope Cruz',
          imagePath: 'assets/artworks/phograph/1.jpg',
          description: 'روح الفلامنكو تتجسد في حركات ديناميكية وألوان حارة.',
          category: 'Performance Art',
        ),
        ArtworkModel(
          id: 30,
          title: 'Andalusian Gardens',
          artistName: 'Penélope Cruz',
          imagePath: 'assets/artworks/phograph/2.jpg',
          description: 'حدائق الأندلس بعبقها العربي الأصيل.',
          category: 'Oil Painting',
        ),
        ArtworkModel(
          id: 31,
          title: 'Mediterranean Light',
          artistName: 'Penélope Cruz',
          imagePath: 'assets/artworks/phograph/3.jpg',
          description: 'ضوء البحر المتوسط الذهبي على السواحل الإسبانية.',
          category: 'Impressionism',
        ),
        ArtworkModel(
          id: 32,
          title: 'Spanish Mosaic',
          artistName: 'Penélope Cruz',
          imagePath: 'assets/artworks/phograph/4.jpg',
          description: 'فسيفساء إسبانية تحكي قصص التاريخ والثقافة.',
          category: 'Mosaic Art',
        ),
      ],
    ),
    ArtistModel(
      name: 'Cate Blanchett',
      bio: 'فنانة أسترالية تجمع بين المسرح والفنون البصرية في أعمال تجريبية.',
      profileImage: 'assets/artists/health/3.jpg',
      birthYear: '1969',
      nationality: 'Australian',
      artworks: [
        ArtworkModel(
          id: 33,
          title: 'Theatrical Visions',
          artistName: 'Cate Blanchett',
          imagePath: 'assets/artworks/health/1.jpg',
          description: 'رؤى مسرحية تتجسد في تركيبات بصرية معقدة.',
          category: 'Mixed Media',
        ),
        ArtworkModel(
          id: 34,
          title: 'Character Studies',
          artistName: 'Cate Blanchett',
          imagePath: 'assets/artworks/health/2.jpg',
          description: 'دراسات شخصيات مختلفة من خلال البورتريه التعبيري.',
          category: 'Portrait Art',
        ),
        ArtworkModel(
          id: 35,
          title: 'Stage Lights',
          artistName: 'Cate Blanchett',
          imagePath: 'assets/artworks/health/3.jpg',
          description: 'أضواء المسرح وتأثيرها الدرامي على المساحة والزمن.',
          category: 'Light Installation',
        ),
        ArtworkModel(
          id: 36,
          title: 'Metamorphosis',
          artistName: 'Cate Blanchett',
          imagePath: 'assets/artworks/health/4.jpg',
          description: 'التحول والتطور من خلال سلسلة من التجارب البصرية.',
          category: 'Video Art',
        ),
      ],
    ),
  ];
  

  static List<ArtistModel> get allArtists => _artists;

  static List<ArtworkModel> get allArtworks {
    return _artists.expand((artist) => artist.artworks).toList();
  }

  static ArtistModel? getArtistByName(String name) {
    try {
      return _artists.firstWhere((artist) => artist.name == name);
    } catch (e) {
      return null;
    }
  }

  static List<ArtworkModel> getArtworksByArtist(String artistName) {
    final artist = getArtistByName(artistName);
    return artist?.artworks ?? [];
  }

  static ArtworkModel? getArtworkById(int id) {
    try {
      return allArtworks.firstWhere((artwork) => artwork.id == id);
    } catch (e) {
      return null;
    }
  }
}