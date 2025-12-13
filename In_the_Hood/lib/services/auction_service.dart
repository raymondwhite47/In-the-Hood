import '../models/auction_model.dart';

class AuctionService {
  AuctionService();

  final List<AuctionModel> _auctions = [
    AuctionModel(
      id: 'a1',
      title: 'Vintage Bike',
      description: 'Restored 80s road bike ready for weekend rides.',
      startingBid: 120.0,
      currentBid: 135.0,
      endsAt: DateTime.now().add(const Duration(hours: 5)),
    ),
    AuctionModel(
      id: 'a2',
      title: 'Concert Tickets',
      description: 'Two seats for the downtown summer festival.',
      startingBid: 60.0,
      currentBid: 80.0,
      endsAt: DateTime.now().add(const Duration(hours: 12)),
    ),
  ];

  List<AuctionModel> fetchAuctions() => List<AuctionModel>.unmodifiable(_auctions);

  AuctionModel? getAuctionById(String id) {
    for (final auction in _auctions) {
      if (auction.id == id) {
        return auction;
      }
    }
    return null;
  }

  AuctionModel createAuction({
    required String title,
    required String description,
    required double startingBid,
    DateTime? endsAt,
  }) {
    final auction = AuctionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      startingBid: startingBid,
      currentBid: startingBid,
      endsAt: endsAt ?? DateTime.now().add(const Duration(days: 1)),
    );
    _auctions.add(auction);
    return auction;
  }

  AuctionModel placeBid({required String auctionId, required double amount}) {
    final auctionIndex = _auctions.indexWhere((auction) => auction.id == auctionId);
    if (auctionIndex == -1) {
      throw ArgumentError('Auction not found');
    }
    final currentAuction = _auctions[auctionIndex];
    if (!currentAuction.isActive || amount <= currentAuction.currentBid) {
      return currentAuction;
    }
    final updatedAuction = currentAuction.copyWith(currentBid: amount);
    _auctions[auctionIndex] = updatedAuction;
    return updatedAuction;
  }
}
