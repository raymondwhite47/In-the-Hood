class AnalyticsEventModel {
  final String type; // 'listing_created', 'auction_bid', etc.
  final String userId;
  final DateTime timestamp;

  AnalyticsEventModel({required this.type, required this.userId, required this.timestamp});

  Map<String, dynamic> toMap() => {
    'type': type,
    'userId': userId,
    'timestamp': timestamp.toIso8601String(),
  };
}
