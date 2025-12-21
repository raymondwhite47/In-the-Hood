class BusinessAdModel {
  final String id;
  final String businessName;
  final String description;
  final String imageUrl;
  final double price;
  final String ownerId;
  final DateTime startDate;
  final DateTime endDate;

  BusinessAdModel({
    required this.id,
    required this.businessName,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.ownerId,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'businessName': businessName,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
        'ownerId': ownerId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      };

  factory BusinessAdModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BusinessAdModel(
      id: documentId,
      businessName: data['businessName'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      ownerId: data['ownerId'] ?? '',
      startDate: DateTime.parse(data['startDate']),
      endDate: DateTime.parse(data['endDate']),
    );
  }
}
