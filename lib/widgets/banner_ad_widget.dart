import 'package:flutter/material.dart';

import '../services/ad_service.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late final AdService _adService;
  String? _adUnitId;

  @override
  void initState() {
    super.initState();
    _adService = AdService();
    _loadAd();
  }

  Future<void> _loadAd() async {
    final String bannerId = await _adService.loadBannerAdId();
    setState(() {
      _adUnitId = bannerId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_adUnitId == null) {
      return const SizedBox(height: 56, child: Center(child: CircularProgressIndicator()));
    }

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text('Banner Ad: $_adUnitId', style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}
