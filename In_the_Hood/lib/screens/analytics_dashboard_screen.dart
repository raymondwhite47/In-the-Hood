import 'package:flutter/material.dart';
import '../../services/analytics_service.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AnalyticsService();

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: StreamBuilder<Map<String, int>>(
        stream: service.getStats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final stats = snapshot.data!;
          return ListView(
            children: stats.entries.map((e) => ListTile(
              title: Text(e.key),
              trailing: Text(e.value.toString()),
            )).toList(),
          );
        },
      ),
    );
  }
}
