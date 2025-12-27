import 'aws_store.dart';

class TrustService {
  final AwsStore _store = AwsStore.instance;

  Future<double> calculateTrust(String userId) async {
    final userDoc = _store.get('users', userId) ?? {};
    final trades = userDoc['completedTrades'] ?? 0;
    final reports = userDoc['reports'] ?? 0;
    double score = (50 + (trades * 5) - (reports * 10)).toDouble();
    return score.clamp(0, 100);
  }

  Future<void> updateTrust(String userId) async {
    final score = await calculateTrust(userId);
    _store.update('users', userId, {'trustScore': score});
  }
}
