import 'package:flutter/material.dart';

import '../../services/hood_coin_service.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final hoodCoinService = HoodCoinService();

    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: Center(
        child: StreamBuilder<int>(
          stream: hoodCoinService.watchBalance(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Unable to load your HoodCoins right now.');
            }
            final coins = snapshot.data ?? 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Your HoodCoins', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  '$coins 💰',
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => hoodCoinService.addCoins(userId, 10),
                  child: const Text('Earn 10 by Watching Ad'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
