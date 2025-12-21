import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/auction_model.dart';

class AuctionService {
  final CollectionReference auctionsRef = FirebaseFirestore.instance.collection('auctions');

  Future<void> createAuction(AuctionModel auction) async {
    await auctionsRef.doc(auction.id).set(auction.toMap());
  }

  Future<void> placeBid(String auctionId, double newBid, String userId) async {
    await auctionsRef.doc(auctionId).update({
      'currentBid': newBid,
      'highestBidderId': userId,
    });
  }

  Stream<List<AuctionModel>> getActiveAuctions() {
    return auctionsRef
        .orderBy('endTime', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => AuctionModel.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }
}
