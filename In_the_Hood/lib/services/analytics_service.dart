import '../models/analytics_event_model.dart';
import 'aws_store.dart';

class AnalyticsService {
  final AwsStore _store = AwsStore.instance;

  Future<void> logEvent(AnalyticsEventModel event) async {
    _store.add('analytics_events', event.toMap());
  }

  Stream<Map<String, int>> getStats() {
    return _store.watch('analytics_events').map((items) {
      final stats = <String, int>{};
      for (var doc in items) {
        final type = doc['type'] as String? ?? 'unknown';
        stats[type] = (stats[type] ?? 0) + 1;
      }
      return stats;
    });
  }
}
