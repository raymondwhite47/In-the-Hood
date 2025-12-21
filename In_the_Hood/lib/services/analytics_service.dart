import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/analytics_event_model.dart';

class AnalyticsService {
  final _events = FirebaseFirestore.instance.collection('analytics_events');

  Future<void> logEvent(AnalyticsEventModel event) async {
    await _events.add(event.toMap());
  }

  Stream<Map<String, int>> getStats() {
    return _events.snapshots().map((snap) {
      final stats = <String, int>{};
      for (var doc in snap.docs) {
        stats[doc['type']] = (stats[doc['type']] ?? 0) + 1;
      }
      return stats;
    });
  }
}
