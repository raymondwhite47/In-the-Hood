import 'aws_store.dart';

class FeedRecommendationService {
  final AwsStore _store = AwsStore.instance;

  Future<List<Map<String, dynamic>>> getPersonalizedFeed(String userId, String location) async {
    // Get recent posts, prioritize by distance and engagement
    final posts = _store.list('feed_posts');

    posts.sort((a, b) {
      double scoreA = (a['likes'] ?? 0) + (a['comments'] ?? 0) * 2;
      double scoreB = (b['likes'] ?? 0) + (b['comments'] ?? 0) * 2;
      return scoreB.compareTo(scoreA);
    });

    return posts.take(20).toList(); // personalized top feed
  }
}
