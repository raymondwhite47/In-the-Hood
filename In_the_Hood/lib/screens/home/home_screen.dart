import 'package:flutter/material.dart';

import '../../models/listing_model.dart';
import '../../services/listing_service.dart';
import '../../widgets/banner_ad_widget.dart';
import '../../widgets/listing_card.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';
import 'listing_details.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ListingService listingService = ListingService();
    final List<ListingModel> listings = listingService.getFeaturedListings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('In the Hood'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: <Widget>[
          const BannerAdWidget(),
          const SizedBox(height: 16),
          Text('Featured near you', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          for (final ListingModel listing in listings)
            ListingCard(
              listing: listing,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ListingDetails(listing: listing)),
                );
              },
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MapScreen()));
                },
                icon: const Icon(Icons.map),
                label: const Text('View map'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChatScreen()));
                },
                icon: const Icon(Icons.chat),
                label: const Text('Open chat'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
