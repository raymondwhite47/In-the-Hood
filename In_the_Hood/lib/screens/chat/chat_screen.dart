import 'package:flutter/material.dart';

import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import '../../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chat, required this.chatService});

  final ChatModel chat;
  final ChatService chatService;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<MessageModel>> _messagesFuture;
  final List<MessageModel> _localMessages = [];

  @override
  void initState() {
    super.initState();
    _messagesFuture = widget.chatService.fetchMessages(widget.chat.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;
    final message = await widget.chatService.sendMessage(
      chatId: widget.chat.id,
      sender: 'You',
      content: content,
    );
    setState(() {
      _localMessages.add(message);
      _controller.clear();
    });

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  List<ChatThread> _demoThreads() {
    return <ChatThread>[
      ChatThread(
        id: 'bike',
        participants: const <String>['Demo User', 'Sam'],
        messages: <ChatMessage>[
          ChatMessage(sender: 'Sam', content: 'Is the bike still available?', timestamp: DateTime.now()),
          ChatMessage(sender: 'Demo User', content: 'Yes! Want to test ride this weekend?', timestamp: DateTime.now()),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chat.title)),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<MessageModel>>(
              future: _messagesFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = [...snapshot.data!, ..._localMessages];
                if (messages.isEmpty) {
                  return const Center(child: Text('No messages yet. Say hello!'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isOwnMessage = message.sender == 'You';
                    return Align(
                      alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isOwnMessage ? Colors.blue.shade100 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.sender,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(message.content),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Message your neighbors...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
    final List<ChatThread> threads = _demoThreads();
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView.builder(
        itemCount: threads.length,
        itemBuilder: (BuildContext context, int index) {
          final ChatThread thread = threads[index];
          final ChatMessage lastMessage = thread.messages.last;
          return ListTile(
            leading: CircleAvatar(child: Text(thread.participants.first[0])),
            title: Text(thread.participants.join(' & ')),
            subtitle: Text(lastMessage.content),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}
