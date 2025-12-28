import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Chat"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                mainAxisAlignment: .spaceBetween,
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.sentiment_satisfied),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Type a message...",
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
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
}
