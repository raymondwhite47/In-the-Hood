import 'package:flutter/material.dart';

import '../../services/auction_service.dart';
import 'auction_details_screen.dart';

class CreateAuctionScreen extends StatefulWidget {
  const CreateAuctionScreen({super.key, required this.auctionService});

  final AuctionService auctionService;

  @override
  State<CreateAuctionScreen> createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startingBidController = TextEditingController();
  DateTime? _selectedEndDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startingBidController.dispose();
    super.dispose();
  }

  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: now,
      initialDate: now.add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 30)),
    );
    if (pickedDate != null) {
      setState(() => _selectedEndDate = pickedDate);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final auction = widget.auctionService.createAuction(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      startingBid: double.parse(_startingBidController.text),
      endsAt: _selectedEndDate?.add(const Duration(hours: 23, minutes: 59)),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AuctionDetailsScreen(auction: auction, auctionService: widget.auctionService),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Auction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Enter a description' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _startingBidController,
                decoration: const InputDecoration(labelText: 'Starting Bid'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter a starting bid';
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('End Date'),
                subtitle: Text(
                  _selectedEndDate != null
                      ? _selectedEndDate!.toLocal().toString().split(' ').first
                      : 'Select a date',
                ),
                trailing: TextButton(
                  onPressed: _pickEndDate,
                  child: const Text('Choose'),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create Auction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
