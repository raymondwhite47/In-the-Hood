import 'aws_store.dart';

class HoodCoinService {
  final AwsStore _store = AwsStore.instance;

  Future<void> addCoins(String userId, int amount) async {
    final current = _store.get('users', userId)?['hoodCoins'] as int? ?? 0;
    _store.update('users', userId, {'hoodCoins': current + amount});
  }

  Future<void> spendCoins(String userId, int amount) async {
    final current = _store.get('users', userId)?['hoodCoins'] as int? ?? 0;
    if (current >= amount) {
      _store.update('users', userId, {'hoodCoins': current - amount});
    } else {
      throw Exception("Not enough HoodCoins");
    }
  }

  Stream<int> watchBalance(String userId) {
    return _store.watch('users').map((items) {
      final user = items.firstWhere((item) => item['id'] == userId, orElse: () => {});
      return user['hoodCoins'] as int? ?? 0;
    });
  }
}
