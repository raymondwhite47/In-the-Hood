import 'package:cloud_firestore/cloud_firestore.dart';

class Listing {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String userId;
  final GeoPoint location;
  final Timestamp createdAt;

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
        'location': location,
        'createdAt': createdAt,
      };


  factory Listing.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Listing(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
      location: data['location'] ?? GeoPoint(0, 0),
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  factory Listing.fromMap(Map<String, dynamic> data, String documentId) {
    return Listing(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
      location: data['location'] ?? GeoPoint(0, 0),
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
