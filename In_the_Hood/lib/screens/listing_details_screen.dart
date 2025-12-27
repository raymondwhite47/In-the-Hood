import 'package:flutter/material.dart';
import 'package:in_the_hood/models/listing_model.dart';
import 'package:in_the_hood/widgets/listing_card.dart';

class ListingDetailsScreen extends StatelessWidget {
  final Listing listing;

  const ListingDetailsScreen({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listing.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              listing.imageUrl,
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\$${listing.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Text(listing.description),
                  const SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle contact
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Contact Seller'),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'More from this seller',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Placeholder listings
                        SizedBox(
                          width: 200,
                          child: ListingCard(listing: listing),
                        ),
                        SizedBox(
                          width: 200,
                          child: ListingCard(listing: listing),
                        ),
                        SizedBox(
                          width: 200,
                          child: ListingCard(listing: listing),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
