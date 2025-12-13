class AuctionModel {
  const AuctionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startingBid,
    required this.currentBid,
    required this.endsAt,
    this.isActive = true,
  });

  final String id;
  final String title;
  final String description;
  final double startingBid;
  final double currentBid;
  final DateTime endsAt;
  final bool isActive;

  AuctionModel copyWith({
    String? id,
    String? title,
    String? description,
    double? startingBid,
    double? currentBid,
    DateTime? endsAt,
    bool? isActive,
  }) {
    return AuctionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startingBid: startingBid ?? this.startingBid,
      currentBid: currentBid ?? this.currentBid,
      endsAt: endsAt ?? this.endsAt,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startingBid': startingBid,
      'currentBid': currentBid,
      'endsAt': endsAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory AuctionModel.fromJson(Map<String, dynamic> json) {
    return AuctionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startingBid: (json['startingBid'] as num).toDouble(),
      currentBid: (json['currentBid'] as num).toDouble(),
      endsAt: DateTime.parse(json['endsAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
