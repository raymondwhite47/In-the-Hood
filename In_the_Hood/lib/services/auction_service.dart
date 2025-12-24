import '../models/auction_model.dart';
import 'aws_store.dart';

class AuctionService {
  final AwsStore _store = AwsStore.instance;

  Future<void> createAuction(AuctionModel auction) async {
    _store.set('auctions', auction.id, auction.toMap());
  }

  Future<void> placeBid(String auctionId, double newBid, String userId) async {
    _store.update('auctions', auctionId, {
      'currentBid': newBid,
      'highestBidderId': userId,
    });
  }

  Stream<List<AuctionModel>> getActiveAuctions() {
    return _store.watch('auctions').map((items) {
      final auctions = items.map((doc) => AuctionModel.fromMap(doc)).toList();
      auctions.sort((a, b) => a.endTime.compareTo(b.endTime));
      return auctions;
    });
  }
}
