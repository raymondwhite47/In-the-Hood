import 'aws_store.dart';

class PointsService {
  final AwsStore _store = AwsStore.instance;

  Future<void> addPoints(String userId, int amount) async {
    final current = _store.get('user_points', userId)?['points'] as int? ?? 0;
    _store.set('user_points', userId, {'userId': userId, 'points': current + amount});
  }

  Future<int> getPoints(String userId) async {
    return _store.get('user_points', userId)?['points'] as int? ?? 0;
  }

  Stream<int> watchPoints(String userId) {
    return _store.watch('user_points').map((items) {
      final entry = items.firstWhere((item) => item['id'] == userId, orElse: () => {});
      return entry['points'] as int? ?? 0;
    });
  }
}
