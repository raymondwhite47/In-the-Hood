import 'package:cloud_firestore/cloud_firestore.dart';

class PointsService {
  final pointsRef = FirebaseFirestore.instance.collection('user_points');

  Future<void> addPoints(String userId, int amount) async {
    final doc = await pointsRef.doc(userId).get();
    if (!doc.exists) {
      await pointsRef.doc(userId).set({'userId': userId, 'points': amount});
    } else {
      await pointsRef.doc(userId).update({'points': FieldValue.increment(amount)});
    }
  }

  Future<int> getPoints(String userId) async {
    final doc = await pointsRef.doc(userId).get();
    return doc.exists ? doc['points'] : 0;
  }

  Stream<int> watchPoints(String userId) {
    return pointsRef.doc(userId).snapshots().map((doc) => (doc.data()?['points'] ?? 0) as int);
  }
}
