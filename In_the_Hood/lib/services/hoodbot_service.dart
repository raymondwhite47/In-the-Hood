import 'dart:convert';
import 'package:http/http.dart' as http;

class HoodBotService {
  final String apiKey = "YOUR_OPENAI_API_KEY";

  Future<String> askHoodBot(String question, String userCity) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {"role": "system", "content": "You are HoodBot, a friendly AI that gives hyperlocal advice and recommendations."},
          {"role": "user", "content": "City: $userCity"},
          {"role": "user", "content": question},
        ],
      }),
    );

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  }
}
