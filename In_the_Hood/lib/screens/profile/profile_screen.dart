import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const UserModel user = UserModel(
      id: 'demo',
      name: 'Demo User',
      email: 'demo@inthehood.app',
      hoodPoints: 420,
      verified: true,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(radius: 30, child: Text(user.name[0])),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(user.email),
                    if (user.verified) const Chip(label: Text('Verified neighbor')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                title: const Text('Hood Points'),
                subtitle: const Text('Earn points for helping neighbors and staying active.'),
                trailing: Text(user.hoodPoints.toString()),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                title: const Text('Marketplace reputation'),
                subtitle: const Text('Track your trust score as you complete trades.'),
                trailing: Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
