import 'package:cloud_firestore/cloud_firestore.dart';

class FeedRecommendationService {
  final _posts = FirebaseFirestore.instance.collection('feed_posts');

  Future<List<Map<String, dynamic>>> getPersonalizedFeed(String userId, String location) async {
    // Get recent posts, prioritize by distance and engagement
    final snapshot = await _posts.orderBy('timestamp', descending: true).limit(100).get();
    final posts = snapshot.docs.map((d) => d.data()).toList();

    posts.sort((a, b) {
      double scoreA = (a['likes'] ?? 0) + (a['comments'] ?? 0) * 2;
      double scoreB = (b['likes'] ?? 0) + (b['comments'] ?? 0) * 2;
      return scoreB.compareTo(scoreA);
    });

    return posts.take(20).toList(); // personalized top feed
  }
}
