class AttractionSite {
  String? id; // Firestore document ID
  String name;
  String categoryName;
  String town;
  String description;
  double latitude;
  double longitude;
  String? websiteUrl;
  String? phoneNumber;
  int rating;
  String primaryImage;
  List<String> additionalImages;

  AttractionSite({
    this.id,
    required this.name,
    required this.categoryName,
    required this.town,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.websiteUrl,
    this.phoneNumber,
    this.rating = 0,
    required this.primaryImage,
    required this.additionalImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'categoryName': categoryName,
      'town': town,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'websiteUrl': websiteUrl,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'primaryImage': primaryImage,
      'additionalImages': additionalImages,
    };
  }
  
  factory AttractionSite.fromMap(Map<String, dynamic> map, String documentId) {
    return AttractionSite(
      id: documentId,
      name: map['name'] ?? '',
      categoryName: map['categoryName'] ?? '',
      town: map['town'] ?? '',
      description: map['description'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      websiteUrl: map['websiteUrl'],
      phoneNumber: map['phoneNumber'],
      rating: map['rating'] ?? 0,
      primaryImage: map['primaryImage'] ?? '',
      additionalImages: List<String>.from(map['additionalImages'] ?? []),
    );
  }
}
