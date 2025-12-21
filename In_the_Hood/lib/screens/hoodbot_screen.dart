import 'package:flutter/material.dart';
import '../../services/hoodbot_service.dart';

class HoodBotScreen extends StatefulWidget {
  const HoodBotScreen({super.key});

  @override
  State<HoodBotScreen> createState() => _HoodBotScreenState();
}

class _HoodBotScreenState extends State<HoodBotScreen> {
  final _botService = HoodBotService();
  final _controller = TextEditingController();
  String _response = "";

  Future<void> _askBot() async {
    final reply = await _botService.askHoodBot(_controller.text, "Atlanta");
    setState(() => _response = reply);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HoodBot Assistant")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: const InputDecoration(labelText: "Ask HoodBot something...")),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _askBot, child: const Text("Ask")),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: Text(_response))),
          ],
        ),
      ),
    );
  }
}
