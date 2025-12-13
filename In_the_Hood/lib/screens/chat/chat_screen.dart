import 'package:flutter/material.dart';

import '../../models/chat_model.dart';

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
