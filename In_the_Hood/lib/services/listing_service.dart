import 'package:in_the_hood/models/listing_model.dart';
import 'aws_store.dart';

class ListingService {
  final AwsStore _store = AwsStore.instance;

  Future<void> addListing(Listing listing) async {
    _store.add('listings', listing.toMap());
  }

  Stream<List<Listing>> getListings() {
    return _store.watch('listings').map((items) {
      return items.map((data) => Listing.fromMap(data, data['id'] as String)).toList();
    });
  }
}
