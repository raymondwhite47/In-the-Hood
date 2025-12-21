import 'package:cloud_firestore/cloud_firestore.dart';

class TrustService {
  final usersRef = FirebaseFirestore.instance.collection('users');

  Future<double> calculateTrust(String userId) async {
    final userDoc = await usersRef.doc(userId).get();
    final trades = userDoc['completedTrades'] ?? 0;
    final reports = userDoc['reports'] ?? 0;
    double score = (50 + (trades * 5) - (reports * 10)).toDouble();
    return score.clamp(0, 100);
  }

  Future<void> updateTrust(String userId) async {
    final score = await calculateTrust(userId);
    await usersRef.doc(userId).update({'trustScore': score});
  }
}
