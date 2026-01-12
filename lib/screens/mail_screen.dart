import "package:flutter/material.dart";

// Add Logic

class MailScreen extends StatelessWidget {
  const MailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Mail"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 312,
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const InboxScreen(),
                                  ),
                                );
                              },
                              leading: const Icon(Icons.inbox_outlined),
                              title: const Text("Inbox"),
                              trailing: Chip(
                                padding: const .all(4),
                                label: const Text("2"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 312,
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.star_outline),
                              title: const Text("Starred"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 312,
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.send_outlined),
                              title: const Text("Sent"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 312,
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.drafts_outlined),
                              title: const Text("Drafts"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 312,
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.report_outlined),
                              title: const Text("Spam"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 312,
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.delete_outline),
                              title: const Text("Trash"),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Inbox"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .end,
                children: [
                  FilledButton(
                    onPressed: () {},
                    child: const Text("New Email"),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EmailViewScreen(),
                          ),
                        );
                      },
                      leading: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star_outline),
                      ),
                      title: const Text("Github"),
                      subtitle: const Text(
                        "[Repository] New pull request submitted",
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}

class EmailViewScreen extends StatelessWidget {
  const EmailViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("[Repository] New pull request submitted"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      CircleAvatar(child: const Text("A")),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          const Text("Github - notifications@github.com"),
                          const Text("Today at 5:53"),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.reply_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.reply_all_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.forward_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star_outline),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.archive_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    "A new pull request has been submitted to your repository. Please review the changes when you have a moment. The changes include bug fixes and new features for the authentication module.",
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
