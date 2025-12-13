class ChatMessage {
  const ChatMessage({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  final String sender;
  final String content;
  final DateTime timestamp;
}

class ChatThread {
  const ChatThread({
    required this.id,
    required this.participants,
    required this.messages,
  });

  final String id;
  final List<String> participants;
  final List<ChatMessage> messages;
}
