import 'dart:async';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatService {
  final Map<String, List<MessageModel>> _messagesByChat = {};
  final Map<String, StreamController<List<MessageModel>>> _controllers = {};

  String getChatId(String currentUserId, String otherUserId) {
    final ids = [currentUserId, otherUserId]..sort();
    return ids.join('_');
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _controller(chatId).stream;
  }

  Future<void> sendMessage(String chatId, MessageModel message) async {
    final messages = _messagesByChat.putIfAbsent(chatId, () => []);
    messages.insert(0, message);
    _notify(chatId);
  }

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
    return _messagesByChat[chatId] ?? _seedMessages(chatId);
  }

  List<MessageModel> _seedMessages(String chatId) {
    return [
      MessageModel(
        senderId: 'alex',
        receiverId: 'you',
        content: 'Hey neighbors!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      MessageModel(
        senderId: 'you',
        receiverId: 'alex',
        content: 'Hi Alex, what’s up?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
    ];
  }

  StreamController<List<MessageModel>> _controller(String chatId) {
    return _controllers.putIfAbsent(
      chatId,
      () => StreamController<List<MessageModel>>.broadcast(
        onListen: () => _notify(chatId),
      ),
    );
  }

  void _notify(String chatId) {
    final controller = _controllers[chatId];
    if (controller == null || controller.isClosed) {
      return;
    }
    controller.add(List<MessageModel>.from(_messagesByChat[chatId] ?? []));
  }
}
