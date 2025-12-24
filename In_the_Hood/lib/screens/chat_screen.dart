import 'package:flutter/material.dart';
import '../../services/chat_service.dart';
import '../../models/message_model.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;

  const ChatScreen({super.key, required this.currentUserId, required this.otherUserId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatService = ChatService();
  final _msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatId = _chatService.getChatId(widget.currentUserId, widget.otherUserId);

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _chatService.getMessages(chatId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMine = msg.senderId == widget.currentUserId;
                    return Align(
                      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMine ? Colors.deepPurpleAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(msg.content, style: TextStyle(color: isMine ? Colors.white : Colors.black)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _msgCtrl, decoration: const InputDecoration(hintText: 'Message...'))),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_msgCtrl.text.trim().isNotEmpty) {
                      final message = MessageModel(
                        senderId: widget.currentUserId,
                        receiverId: widget.otherUserId,
                        content: _msgCtrl.text.trim(),
                        timestamp: DateTime.now(),
                      );
                      _chatService.sendMessage(chatId, message);
                      _msgCtrl.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
