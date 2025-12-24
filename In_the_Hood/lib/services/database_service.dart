import 'package:in_the_hood/models/listing_model.dart';
import 'aws_store.dart';

class DatabaseService {
  final AwsStore _store = AwsStore.instance;

  Stream<List<Listing>> getListings() {
    return _store.watch('listings').map(
          (items) => items.map((data) => Listing.fromMap(data, data['id'] as String)).toList(),
        );
  }

  Future<void> addListing({
    required String title,
    required String description,
    required double price,
    required String imageUrl,
    required String userId,
  }) {
    _store.add('listings', {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'userId': userId,
      'location': const LocationPoint(latitude: 0, longitude: 0).toMap(),
      'createdAt': DateTime.now().toIso8601String(),
    });
    return Future.value();
  }

  Future<Map<String, int>> getAnalytics() async {
    return {
      'users': _store.list('users').length,
      'listings': _store.list('listings').length,
      'transactions': _store.list('transactions').length,
    };
  }
}
