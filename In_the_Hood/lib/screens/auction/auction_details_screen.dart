import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/auction_model.dart';
import '../../services/auction_service.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Bid placed successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _currentAuction.endsAt.difference(DateTime.now());
    final remainingMinutes = remaining.isNegative ? 0 : remaining.inMinutes;
    final remainingSeconds = remaining.isNegative ? 0 : remaining.inSeconds % 60;
    final remainingLabel = _currentAuction.isActive
        ? '${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}'
        : '00:00';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          _currentAuction.title,
          style: GoogleFonts.orbitron(color: Colors.cyanAccent),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '⏱ Ends in $remainingLabel',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFFD700),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Current Bid',
                    style: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    '\$${_currentAuction.currentBid.toStringAsFixed(2)}',
                    style: GoogleFonts.orbitron(
                      color: Colors.cyanAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _currentAuction.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _bidController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      hintText: 'Enter your bid',
                      hintStyle:
                          const TextStyle(color: Colors.white38, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.cyanAccent,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.cyanAccent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _currentAuction.isActive ? _placeBid : null,
                  child: Text(
                    'Place Bid',
                    style: GoogleFonts.orbitron(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (!_currentAuction.isActive)
              const Text(
                'This auction has ended.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
