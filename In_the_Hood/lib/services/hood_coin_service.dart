import 'package:cloud_firestore/cloud_firestore.dart';

class HoodCoinService {
  HoodCoinService({FirebaseFirestore? firestore})
      : _usersRef = (firestore ?? FirebaseFirestore.instance).collection('users');

  final CollectionReference<Map<String, dynamic>> _usersRef;

  Future<void> addCoins(String userId, int amount) async {
    await _usersRef.doc(userId).update({'hoodCoins': FieldValue.increment(amount)});
  }

  Future<void> spendCoins(String userId, int amount) async {
    final snapshot = await _usersRef.doc(userId).get();
    final data = snapshot.data();
    final current = (data?['hoodCoins'] as int?) ?? 0;

    if (current < amount) {
      throw Exception('Not enough HoodCoins');
    }

    await _usersRef.doc(userId).update({'hoodCoins': current - amount});
  }

  Stream<int> watchBalance(String userId) {
    return _usersRef
        .doc(userId)
        .snapshots()
        .map((doc) => (doc.data()?['hoodCoins'] as int?) ?? 0);
  }
}
