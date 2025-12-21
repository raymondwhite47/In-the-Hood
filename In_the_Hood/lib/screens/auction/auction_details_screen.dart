import 'package:flutter/material.dart';

import '../../models/auction_model.dart';
import '../../services/auction_service.dart';
import '../../widgets/dynamic_background.dart';

class AuctionDetailsScreen extends StatefulWidget {
  const AuctionDetailsScreen({super.key, required this.auction, required this.auctionService});

  final AuctionModel auction;
  final AuctionService auctionService;

  @override
  State<AuctionDetailsScreen> createState() => _AuctionDetailsScreenState();
}

class _AuctionDetailsScreenState extends State<AuctionDetailsScreen> {
  final TextEditingController _bidController = TextEditingController();
  late AuctionModel _currentAuction;

  @override
  void initState() {
    super.initState();
    _currentAuction = widget.auction;
    _bidController.text = (_currentAuction.currentBid + 5).toStringAsFixed(2);
  }

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }

  void _placeBid() {
    final bidAmount = double.tryParse(_bidController.text);
    if (bidAmount == null || bidAmount <= _currentAuction.currentBid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a bid higher than the current amount.')),
      );
      return;
    }
    final updatedAuction = widget.auctionService.placeBid(
      auctionId: _currentAuction.id,
      amount: bidAmount,
    );
    setState(() => _currentAuction = updatedAuction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_currentAuction.title)),
      body: Stack(
        children: [
          const DynamicBackground(screenIndex: 2),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentAuction.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentAuction.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Chip(label: Text('Current Bid: $${_currentAuction.currentBid.toStringAsFixed(2)}')),
                      const SizedBox(width: 8),
                      Chip(label: Text('Ends: ${_currentAuction.endsAt.toLocal()}')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _bidController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Your Bid',
                      border: OutlineInputBorder(),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _placeBid,
                    icon: const Icon(Icons.gavel),
                    label: const Text('Place Bid'),
                  ),
                  const SizedBox(height: 24),
                  if (!_currentAuction.isActive)
                    const Text('This auction has ended.', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
