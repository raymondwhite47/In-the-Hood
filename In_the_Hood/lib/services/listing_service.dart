import '../models/listing_model.dart';

class ListingService {
  List<ListingModel> getFeaturedListings() {
    return const <ListingModel>[
      ListingModel(
        id: 'bike',
        title: 'Vintage Bike',
        description: 'Single-speed cruiser restored for weekend rides.',
        price: 120.0,
        neighborhood: 'Downtown',
        imageUrl: null,
      ),
      ListingModel(
        id: 'books',
        title: 'Book Bundle',
        description: 'Neighborhood history collection with annotations.',
        price: 35.0,
        neighborhood: 'Riverside',
        imageUrl: null,
      ),
      ListingModel(
        id: 'desk',
        title: 'Standing Desk',
        description: 'Adjustable desk perfect for home offices.',
        price: 210.0,
        neighborhood: 'Market Street',
        imageUrl: null,
      ),
    ];
  }
}
