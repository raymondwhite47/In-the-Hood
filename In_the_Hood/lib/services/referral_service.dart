import '../models/referral_model.dart';
import 'aws_store.dart';

class ReferralService {
  final AwsStore _store = AwsStore.instance;

  Future<void> addReferral(String referrerId, String referredId) async {
    final referral = ReferralModel(
      referrerId: referrerId,
      referredId: referredId,
      createdAt: DateTime.now(),
    );
    _store.add('referrals', referral.toMap());
    final current = _store.get('users', referrerId)?['hoodCoins'] as int? ?? 0;
    _store.update('users', referrerId, {'hoodCoins': current + 20});
  }

  Stream<List<ReferralModel>> getReferrals(String userId) {
    return _store.watch('referrals').map((items) {
      return items
          .where((item) => item['referrerId'] == userId)
          .map((item) => ReferralModel(
                referrerId: item['referrerId'],
                referredId: item['referredId'],
                createdAt: DateTime.parse(item['createdAt']),
              ))
          .toList();
    });
  }
}
