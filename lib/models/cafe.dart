class Cafe {
  final String id;
  final String name;
  final String tagline;
  final String category;
  final List<String> categories;
  final String address;
  final String subdistrict;
  final double rating;
  final int reviewCount;
  final String openHours;
  final bool isOpen24Hours;
  final String priceRange;
  final String priceLevel;
  final String wifiSpeed;
  final String noiseLevel;
  final String imageUrl;
  final List<String> facilities;
  final List<String> recommendedMenu;
  final String description;
  final String mapsUrl;
  final bool isFavorite;

  const Cafe({
    required this.id,
    required this.name,
    required this.tagline,
    required this.category,
    required this.categories,
    required this.address,
    required this.subdistrict,
    required this.rating,
    required this.reviewCount,
    required this.openHours,
    required this.isOpen24Hours,
    required this.priceRange,
    required this.priceLevel,
    required this.wifiSpeed,
    required this.noiseLevel,
    required this.imageUrl,
    required this.facilities,
    required this.recommendedMenu,
    required this.description,
    required this.mapsUrl,
    this.isFavorite = false,
  });

  factory Cafe.fromJson(Map<String, dynamic> json) {
    return Cafe(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      address: json['address'] as String? ?? '',
      subdistrict: json['subdistrict'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      openHours: json['openHours'] as String? ?? '',
      isOpen24Hours: json['isOpen24Hours'] as bool? ?? false,
      priceRange: json['priceRange'] as String? ?? '',
      priceLevel: json['priceLevel'] as String? ?? '',
      wifiSpeed: json['wifiSpeed'] as String? ?? '',
      noiseLevel: json['noiseLevel'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      facilities: (json['facilities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      recommendedMenu: (json['recommendedMenu'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      description: json['description'] as String? ?? '',
      mapsUrl: json['mapsUrl'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'category': category,
      'categories': categories,
      'address': address,
      'subdistrict': subdistrict,
      'rating': rating,
      'reviewCount': reviewCount,
      'openHours': openHours,
      'isOpen24Hours': isOpen24Hours,
      'priceRange': priceRange,
      'priceLevel': priceLevel,
      'wifiSpeed': wifiSpeed,
      'noiseLevel': noiseLevel,
      'imageUrl': imageUrl,
      'facilities': facilities,
      'recommendedMenu': recommendedMenu,
      'description': description,
      'mapsUrl': mapsUrl,
      'isFavorite': isFavorite,
    };
  }

  Cafe copyWith({
    String? id,
    String? name,
    String? tagline,
    String? category,
    List<String>? categories,
    String? address,
    String? subdistrict,
    double? rating,
    int? reviewCount,
    String? openHours,
    bool? isOpen24Hours,
    String? priceRange,
    String? priceLevel,
    String? wifiSpeed,
    String? noiseLevel,
    String? imageUrl,
    List<String>? facilities,
    List<String>? recommendedMenu,
    String? description,
    String? mapsUrl,
    bool? isFavorite,
  }) {
    return Cafe(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      category: category ?? this.category,
      categories: categories ?? this.categories,
      address: address ?? this.address,
      subdistrict: subdistrict ?? this.subdistrict,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      openHours: openHours ?? this.openHours,
      isOpen24Hours: isOpen24Hours ?? this.isOpen24Hours,
      priceRange: priceRange ?? this.priceRange,
      priceLevel: priceLevel ?? this.priceLevel,
      wifiSpeed: wifiSpeed ?? this.wifiSpeed,
      noiseLevel: noiseLevel ?? this.noiseLevel,
      imageUrl: imageUrl ?? this.imageUrl,
      facilities: facilities ?? this.facilities,
      recommendedMenu: recommendedMenu ?? this.recommendedMenu,
      description: description ?? this.description,
      mapsUrl: mapsUrl ?? this.mapsUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
