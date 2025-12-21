import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_the_hood/models/listing_model.dart';

class ListingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addListing(Listing listing) async {
    await _firestore.collection('listings').add(listing.toMap());
  }

  Stream<List<Listing>> getListings() {
    return _firestore.collection('listings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Listing.fromMap(data, doc.id);
      }).toList();
    });
  }
}
