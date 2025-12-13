class ListingModel {
  const ListingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.neighborhood,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final double price;
  final String neighborhood;
  final String? imageUrl;
}
