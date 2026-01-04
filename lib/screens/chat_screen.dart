import "package:flutter/material.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _controller.text.trim(),
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );

      // Fake reply
      _messages.add(
        ChatMessage(
          text: "This is a mock reply!",
          isMe: false,
          timestamp: DateTime.now(),
        ),
      );
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: const Text("Chat"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(child: const Text("A")),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.phone_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.video_call_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.help_outline),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const .symmetric(vertical: 8),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessage(_messages[index]);
                      },
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.sentiment_satisfied),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (_) => _sendMessage(),
                          controller: _controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Type a message...",
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _sendMessage(),
                        icon: const Icon(Icons.send_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isMe ? .centerRight : .centerLeft,
      child: Container(
        margin: const .symmetric(vertical: 4),
        padding: const .all(12),
        decoration: BoxDecoration(
          color: message.isMe
              ? Colors.blue.withValues(alpha: 0.2)
              : Colors.grey.withValues(alpha: 0.15),
          borderRadius: .circular(12),
        ),
        child: Text(message.text),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}
