import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_the_hood/models/listing_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Listing>> getListings() {
    return _db.collection('listings').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Listing.fromFirestore(doc)).toList());
  }

  Future<void> addListing({
    required String title,
    required String description,
    required double price,
    required String imageUrl,
    required String userId,
  }) {
    return _db.collection('listings').add({
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'userId': userId,
    });
  }

  Future<Map<String, int>> getAnalytics() async {
    final usersQuery = _db.collection('users').count().get();
    final listingsQuery = _db.collection('listings').count().get();
    final transactionsQuery = _db.collection('transactions').count().get();

    final results = await Future.wait([usersQuery, listingsQuery, transactionsQuery]);

    return {
      'users': results[0].count ?? 0,
      'listings': results[1].count ?? 0,
      'transactions': results[2].count ?? 0,
    };
  }
}
