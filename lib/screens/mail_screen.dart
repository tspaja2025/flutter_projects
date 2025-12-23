import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions.dart";

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<StatefulWidget> createState() => MailScreenState();
}

class MailScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              MailListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const MailInboxScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.inbox_outlined),
                title: "Inbox",
                mailCount: "2",
                showMailCount: true,
              ),
              MailListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const MailStarredScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.star_outline),
                title: "Starred",
              ),
              MailListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const MailSentScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.send_outlined),
                title: "Sent",
              ),
              MailListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const MailDraftsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.drafts_outlined),
                title: "Drafts",
              ),
              MailListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const MailSpamScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.report_outlined),
                title: "Spam",
              ),
              MailListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const MailTrashScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline),
                title: "Trash",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MailListTile extends StatefulWidget {
  final Widget icon;
  final String title;
  final String? mailCount;
  final bool showMailCount;
  final VoidCallback onTap;

  const MailListTile({
    super.key,
    required this.icon,
    required this.title,
    this.mailCount,
    this.showMailCount = false,
    required this.onTap,
  });

  @override
  State<MailListTile> createState() => MailListTileState();
}

class MailListTileState extends State<MailListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: ListTile(
          contentPadding: const .symmetric(horizontal: 16),
          leading: widget.icon,
          title: Text(widget.title),
          trailing: widget.showMailCount
              ? Chip(
                  label: Text(widget.mailCount.toString()),
                  padding: const .all(2),
                )
              : null,
        ),
      ),
    );
  }
}

class MailInboxScreen extends StatefulWidget {
  const MailInboxScreen({super.key});

  @override
  State<MailInboxScreen> createState() => MailInboxScreenState();
}

class MailInboxScreenState extends State<MailInboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Inbox"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const MailViewScreen(
                          title: "[Repo] New Pull request submitted",
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(child: const Text("A")),
                    title: const Text("[Repo] New Pull request submitted"),
                    subtitle: const Text("A new request has been submitted..."),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MailStarredScreen extends StatefulWidget {
  const MailStarredScreen({super.key});

  @override
  State<MailStarredScreen> createState() => MailStarredScreenState();
}

class MailStarredScreenState extends State<MailStarredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Starred"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(children: [const Text("Starred screen")]),
        ),
      ),
    );
  }
}

class MailSentScreen extends StatefulWidget {
  const MailSentScreen({super.key});

  @override
  State<MailSentScreen> createState() => MailSentScreenState();
}

class MailSentScreenState extends State<MailSentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Sent"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(children: [const Text("Sent screen")]),
        ),
      ),
    );
  }
}

class MailDraftsScreen extends StatefulWidget {
  const MailDraftsScreen({super.key});

  @override
  State<MailDraftsScreen> createState() => MailDraftsScreenState();
}

class MailDraftsScreenState extends State<MailDraftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Drafts"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(children: [const Text("Drafts screen")]),
        ),
      ),
    );
  }
}

class MailSpamScreen extends StatefulWidget {
  const MailSpamScreen({super.key});

  @override
  State<MailSpamScreen> createState() => MailSpamScreenState();
}

class MailSpamScreenState extends State<MailSpamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Spam"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(children: [const Text("Spam screen")]),
        ),
      ),
    );
  }
}

class MailTrashScreen extends StatefulWidget {
  const MailTrashScreen({super.key});

  @override
  State<MailTrashScreen> createState() => MailTrashScreenState();
}

class MailTrashScreenState extends State<MailTrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Trash"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(children: [const Text("Trash screen")]),
        ),
      ),
    );
  }
}

class MailViewScreen extends StatefulWidget {
  final String title;

  const MailViewScreen({super.key, required this.title});

  @override
  State<MailViewScreen> createState() => MailViewScreenState();
}

class MailViewScreenState extends State<MailViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(widget.title),
                  MenuAnchor(
                    builder: (context, controller, child) {
                      return IconButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: const Icon(Icons.more_vert),
                      );
                    },
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: Icon(Icons.star),
                        child: const Text("Favorite"),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: Icon(Icons.archive),
                        child: const Text("Archive"),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: Icon(Icons.delete),
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(child: const Text("A")),
                title: Row(
                  spacing: 8,
                  children: [
                    const Text("Github"),
                    Text(
                      "notifications@github.com",
                      style: TextTheme.of(
                        context,
                      ).titleSmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Today at 10:50",
                  style: TextTheme.of(
                    context,
                  ).titleSmall?.copyWith(color: Colors.grey),
                ),
              ),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                "A new pull request has been submitted to your repository. Please review the changes when you have a moment. The changes include bug fixes and new features for the authentication module.",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.reply),
      ),
    );
  }
}
