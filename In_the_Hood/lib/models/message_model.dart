class MessageModel {
  const MessageModel({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  final String id;
  final String chatId;
  final String sender;
  final String content;
  final DateTime timestamp;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'sender': sender,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
