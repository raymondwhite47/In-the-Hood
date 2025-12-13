import 'dart:async';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatService {
  ChatService();

  final List<MessageModel> _messages = [];

  Future<List<ChatModel>> fetchChats() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return [
      ChatModel(
        id: '1',
        title: 'Neighborhood Watch',
        participants: const ['Alex', 'Jamie', 'Sam'],
        lastMessage: 'Stay safe out there!',
        updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatModel(
        id: '2',
        title: 'Local Deals',
        participants: const ['Priya', 'Jordan'],
        lastMessage: 'The coffee grinder is still available.',
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];
  }

  Future<List<MessageModel>> fetchMessages(String chatId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (_messages.isNotEmpty) {
      return _messages.where((message) => message.chatId == chatId).toList();
    }
    return [
      MessageModel(
        id: 'm1',
        chatId: chatId,
        sender: 'Alex',
        content: 'Hey neighbors!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      MessageModel(
        id: 'm2',
        chatId: chatId,
        sender: 'You',
        content: 'Hi Alex, what’s up?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
    ];
  }

  Future<MessageModel> sendMessage({
    required String chatId,
    required String sender,
    required String content,
  }) async {
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatId,
      sender: sender,
      content: content,
      timestamp: DateTime.now(),
    );
    _messages.add(message);
    return message;
  }
}
