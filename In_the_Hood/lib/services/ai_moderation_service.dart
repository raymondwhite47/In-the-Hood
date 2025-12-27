import 'dart:convert';
import 'package:http/http.dart' as http;

class AIModerationService {
  final String openAIApiKey = "YOUR_OPENAI_API_KEY"; // Replace with env variable

  Future<bool> isPostAllowed(String content) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/moderations"),
      headers: {
        "Authorization": "Bearer $openAIApiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"input": content}),
    );

    final data = jsonDecode(response.body);
    final results = data['results'][0];

    bool flagged = results['flagged'];
    return !flagged;
  }
}
