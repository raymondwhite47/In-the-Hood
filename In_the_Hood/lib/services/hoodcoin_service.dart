import 'package:cloud_firestore/cloud_firestore.dart';

class HoodCoinService {
  final usersRef = FirebaseFirestore.instance.collection('users');

  Future<void> addCoins(String userId, int amount) async {
    await usersRef.doc(userId).update({'hoodCoins': FieldValue.increment(amount)});
  }

  Future<void> spendCoins(String userId, int amount) async {
    final doc = await usersRef.doc(userId).get();
    int current = doc['hoodCoins'] ?? 0;
    if (current >= amount) {
      await usersRef.doc(userId).update({'hoodCoins': current - amount});
    } else {
      throw Exception("Not enough HoodCoins");
    }
  }

  Stream<int> watchBalance(String userId) {
    return usersRef.doc(userId).snapshots().map((d) => (d.data()?['hoodCoins'] ?? 0) as int);
  }
}
