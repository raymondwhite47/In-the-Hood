import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/referral_model.dart';

class ReferralService {
  final _referrals = FirebaseFirestore.instance.collection('referrals');
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> addReferral(String referrerId, String referredId) async {
    final referral = ReferralModel(
      referrerId: referrerId,
      referredId: referredId,
      createdAt: DateTime.now(),
    );
    await _referrals.add(referral.toMap());
    await _users.doc(referrerId).update({'hoodCoins': FieldValue.increment(20)});
  }

  Stream<List<ReferralModel>> getReferrals(String userId) {
    return _referrals.where('referrerId', isEqualTo: userId).snapshots().map(
      (snap) => snap.docs.map((d) => ReferralModel(
        referrerId: d['referrerId'],
        referredId: d['referredId'],
        createdAt: DateTime.parse(d['createdAt']),
      )).toList(),
    );
  }
}
