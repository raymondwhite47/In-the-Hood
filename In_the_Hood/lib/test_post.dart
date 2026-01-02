import 'package:amplify_flutter/amplify_flutter.dart';
import 'models/Post.dart';

Future<void> createPostAndFetchPosts() async {
  try {
    final newPost = Post(
      title: 'Community Yard Sale',
      body: 'Saturday 8 AM - Bring your stuff!',
      neighborhoodID: 'abc123',
    );

    final createResponse =
        await Amplify.API.mutate(request: ModelMutations.create(newPost))
            .response;

    if (createResponse.data == null) {
      safePrint('❌ Failed to create post: ${createResponse.errors}');
      return;
    }

    safePrint('✅ Post created successfully!');

    final request = ModelQueries.list(Post.classType);
    final response = await Amplify.API.query(request: request).response;

    final posts = response.data?.items;
    posts?.forEach((post) {
      safePrint('📝 ${post!.title}');
    });
  } catch (error) {
    safePrint('❌ Error creating or fetching posts: $error');
  }
}
