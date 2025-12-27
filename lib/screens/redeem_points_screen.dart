import 'package:flutter/material.dart';
import 'package:in_the_hood/models/reward_model.dart';
import 'package:in_the_hood/services/redemption_service.dart';

class RedeemPointsScreen extends StatefulWidget {
  const RedeemPointsScreen({super.key});

  @override
  State<RedeemPointsScreen> createState() => _RedeemPointsScreenState();
}

class _RedeemPointsScreenState extends State<RedeemPointsScreen> {
  final RedemptionService _redemptionService = RedemptionService();

  final List<Reward> rewards = [
    Reward(
      title: 'Coffee Mug',
      description: 'Get a free "In The Hood" coffee mug.',
      points: 100,
    ),
    Reward(
      title: 'T-Shirt',
      description: 'Get a free "In The Hood" t-shirt.',
      points: 200,
    ),
    Reward(
      title: 'Hoodie',
      description: 'Get a free "In The Hood" hoodie.',
      points: 500,
    ),
    Reward(
      title: '\$5 Gift Card',
      description: 'Get a \$5 gift card to your favorite local shop.',
      points: 500,
    ),
     Reward(
      title: '\$10 Gift Card',
      description: 'Get a \$10 gift card to your favorite local shop.',
      points: 1000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem Points'),
      ),
      body: ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(reward.description),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${reward.points} points',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final bool success = await _redemptionService.redeemPoints(reward.points);
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Reward redeemed successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('You do not have enough points to redeem this reward.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text('Redeem'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
