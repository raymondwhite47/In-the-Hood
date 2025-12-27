import 'package:flutter/material.dart';

import '../../models/listing_model.dart';

class ListingDetails extends StatelessWidget {
  const ListingDetails({super.key, required this.listing});

  final ListingModel listing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(listing.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.image, size: 72, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Text(listing.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(listing.description),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Chip(label: Text('\$${listing.price.toStringAsFixed(0)}')),
                const SizedBox(width: 8),
                Chip(label: Text(listing.neighborhood)),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Message seller'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
