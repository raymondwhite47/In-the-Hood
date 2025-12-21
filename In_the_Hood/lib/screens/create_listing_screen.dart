import 'package:flutter/material.dart';
import 'package:in_the_hood/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String _title = '';
  String _description = '';
  double _price = 0;
  String _imageUrl = '';

  Future<void> _createListing() async {
    if (_formKey.currentState!.validate()) {
      await _databaseService.addListing(
        title: _title,
        description: _description,
        price: _price,
        imageUrl: _imageUrl,
        userId: _auth.currentUser!.uid,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Listing'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter a title' : null,
                onChanged: (val) {
                  setState(() => _title = val);
                },
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter a description' : null,
                onChanged: (val) {
                  setState(() => _description = val);
                },
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter a price' : null,
                onChanged: (val) {
                  setState(() => _price = double.parse(val));
                },
                decoration: const InputDecoration(
                  hintText: 'Price',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an image URL' : null,
                onChanged: (val) {
                  setState(() => _imageUrl = val);
                },
                decoration: const InputDecoration(
                  hintText: 'Image URL',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Create'),
                onPressed: () {
                  _createListing().then((_) {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
