import 'package:flutter/material.dart';

import '../../models/chat_model.dart';
import '../../services/chat_service.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key, required this.chatService});

  final ChatService chatService;

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late final ChatService _chatService;
  late Future<List<ChatModel>> _chatsFuture;

  @override
  void initState() {
    super.initState();
    _chatService = widget.chatService;
    _chatsFuture = _chatService.fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: FutureBuilder<List<ChatModel>>(
        future: _chatsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final chats = snapshot.data!;
          if (chats.isEmpty) {
            return const Center(child: Text('No chats yet. Start a conversation!'));
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                title: Text(chat.title),
                subtitle: Text(chat.lastMessage),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.chevron_right),
                    Text('${chat.participants.length} members'),
                  ],
                ),
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(chat: chat, chatService: _chatService),
                    ),
                  );
                  setState(() {
                    _chatsFuture = _chatService.fetchChats();
                  });
                },
              );
            },
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemCount: chats.length,
          );
        },
      ),
    );
  }
}
