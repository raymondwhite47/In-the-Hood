class LocationPoint {
  final double latitude;
  final double longitude;

  const LocationPoint({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() => {'latitude': latitude, 'longitude': longitude};

  factory LocationPoint.fromMap(Map<String, dynamic> data) {
    return LocationPoint(
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
    );
  }
}

class Listing {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String userId;
  final LocationPoint location;
  final DateTime createdAt;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.userId,
    required this.location,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'userId': userId,
        'location': location.toMap(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory Listing.fromMap(Map<String, dynamic> data, String documentId) {
    final locationData = data['location'];
    return Listing(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
      location: locationData is Map<String, dynamic>
          ? LocationPoint.fromMap(locationData)
          : const LocationPoint(latitude: 0, longitude: 0),
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
    );
  }
}
