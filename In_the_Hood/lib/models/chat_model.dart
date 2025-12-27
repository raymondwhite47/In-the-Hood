class ChatModel {
  const ChatModel({
    required this.id,
    required this.title,
    required this.participants,
    required this.lastMessage,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final List<String> participants;
  final String lastMessage;
  final DateTime updatedAt;

  ChatModel copyWith({
    String? id,
    String? title,
    List<String>? participants,
    String? lastMessage,
    DateTime? updatedAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      title: title ?? this.title,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'participants': participants,
      'lastMessage': lastMessage,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      title: json['title'] as String,
      participants: List<String>.from(json['participants'] as List<dynamic>),
      lastMessage: json['lastMessage'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
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
