import 'package:flutter/material.dart';

import '../../services/trust_service.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.trustService});

  final TrustService trustService;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  double? _trustScore;
  bool _isVerifying = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _documentController.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isVerifying = true);
    final isVerified = await widget.trustService.verifyUser(
      fullName: _fullNameController.text.trim(),
      documentId: _documentController.text.trim(),
    );
    final score = await widget.trustService.calculateTrustScore(
      verifications: isVerified ? 1 : 0,
      positiveReviews: isVerified ? 5 : 0,
    );
    setState(() {
      _isVerifying = false;
      _trustScore = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Increase your trust score to unlock premium features and safer trades.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _documentController,
                decoration: const InputDecoration(labelText: 'ID Document Number'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isVerifying ? null : _verify,
                child: _isVerifying
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Submit for Verification'),
              ),
              if (_trustScore != null) ...[
                const SizedBox(height: 24),
                Text('Trust Score: ${_trustScore!.toStringAsFixed(0)} / 100'),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: _trustScore! / 100),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
