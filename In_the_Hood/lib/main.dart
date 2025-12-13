import 'package:flutter/material.dart';

import 'screens/auction/auction_details_screen.dart';
import 'screens/auction/create_auction_screen.dart';
import 'screens/chat/chat_list_screen.dart';
import 'screens/profile/verification_screen.dart';
import 'services/auction_service.dart';
import 'services/chat_service.dart';
import 'services/trust_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In the Hood',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final ChatService _chatService = ChatService();
  final AuctionService _auctionService = AuctionService();
  final TrustService _trustService = TrustService();

  @override
  Widget build(BuildContext context) {
    final sampleAuction = _auctionService.fetchAuctions().first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('In the Hood'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _FeatureCard(
            title: 'Chats',
            description: 'Talk with neighbors and stay updated on local happenings.',
            icon: Icons.chat_bubble_outline,
            actionLabel: 'View chats',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChatListScreen(chatService: _chatService),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _FeatureCard(
            title: 'Auctions',
            description: 'Create auctions and place bids on local deals.',
            icon: Icons.gavel,
            actionLabel: 'View featured auction',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AuctionDetailsScreen(
                    auction: sampleAuction,
                    auctionService: _auctionService,
                  ),
                ),
              );
            },
            trailingAction: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreateAuctionScreen(auctionService: _auctionService),
                  ),
                );
              },
              child: const Text('Create auction'),
            ),
          ),
          const SizedBox(height: 12),
          _FeatureCard(
            title: 'Verification',
            description: 'Boost your trust score with quick identity verification.',
            icon: Icons.verified_user,
            actionLabel: 'Start verification',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => VerificationScreen(trustService: _trustService),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.actionLabel,
    required this.onTap,
    this.trailingAction,
  });

  final String title;
  final String description;
  final IconData icon;
  final String actionLabel;
  final VoidCallback onTap;
  final Widget? trailingAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (trailingAction != null) trailingAction!,
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onTap,
                child: Text(actionLabel),
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
      },
    );
  }
}
