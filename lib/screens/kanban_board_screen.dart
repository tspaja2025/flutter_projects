import "package:flutter/material.dart";

class KanbanBoardScreen extends StatefulWidget {
  const KanbanBoardScreen({super.key});

  @override
  State<KanbanBoardScreen> createState() => KanbanBoardScreenState();
}

class KanbanBoardScreenState extends State<KanbanBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: .start,
                        children: [
                          KanbanColumn(
                            title: "To Do",
                            taskCount: "2",
                            children: [
                              KanbanColumnItem(
                                title: "Design System Setup",
                                content:
                                    "Create a comprehensive design system with colors, typography, and components",
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                priority: "High",
                              ),

                              KanbanColumnItem(
                                title: "API Integration",
                                content:
                                    "Integrate with backend APIs for data fetching",
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                priority: "Medium",
                              ),
                            ],
                          ),

                          KanbanColumn(
                            title: "In Progress",
                            taskCount: "1",
                            children: [
                              KanbanColumnItem(
                                title: "User Authentication",
                                content:
                                    "Implement login and signup functionality",
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                priority: "High",
                              ),
                            ],
                          ),

                          KanbanColumn(
                            title: "Review",
                            taskCount: "1",
                            children: [
                              KanbanColumnItem(
                                title: "Mobile Responsiveness",
                                content:
                                    "Ensure the app works perfectly on mobile devices",
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                priority: "Medium",
                              ),
                            ],
                          ),

                          KanbanColumn(
                            title: "Done",
                            taskCount: "1",
                            children: [
                              KanbanColumnItem(
                                title: "Project Setup",
                                content: "Initialize Flutter project",
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                priority: "Low",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton.filled(
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class KanbanColumn extends StatefulWidget {
  final String title;
  final String taskCount;
  final List<Widget> children;

  const KanbanColumn({
    super.key,
    required this.title,
    required this.taskCount,
    this.children = const [],
  });

  @override
  State<KanbanColumn> createState() => KanbanColumnState();
}

class KanbanColumnState extends State<KanbanColumn> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: Card(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
                  ),
                  const SizedBox(width: 8),
                  Badge(label: Text(widget.taskCount)),
                  const Spacer(),
                  MenuAnchor(
                    childFocusNode: _buttonFocusNode,
                    menuChildren: [
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.add),
                        onPressed: () {},
                        child: const Text("New Task"),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.edit),
                        onPressed: () {},
                        child: const Text("Edit Column"),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Column"),
                                content: const Text(
                                  "Are you sure you want to delete this column? All tasks in this column will be deleted.",
                                ),
                                actions: [
                                  OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: const Text("Column Deleted"),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Delete Column"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text("Delete Column"),
                      ),
                    ],
                    builder: (_, controller, _) {
                      return IconButton(
                        focusNode: _buttonFocusNode,
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => controller.isOpen
                            ? controller.close()
                            : controller.open(),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ...widget.children,
            ],
          ),
        ),
      ),
    );
  }
}

class KanbanColumnItem extends StatefulWidget {
  final String title;
  final String content;
  final String date;
  final String priority;

  const KanbanColumnItem({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.priority,
  });

  @override
  State<KanbanColumnItem> createState() => KanbanColumnItemState();
}

class KanbanColumnItemState extends State<KanbanColumnItem> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
                ),
                const Spacer(),
                MenuAnchor(
                  childFocusNode: _buttonFocusNode,
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon: const Icon(Icons.edit),
                      onPressed: () {},
                      child: const Text("Edit"),
                    ),
                    MenuItemButton(
                      leadingIcon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Task"),
                              content: const Text(
                                "Are you sure you want to delete this task?",
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text("Task Deleted"),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete Task"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Delete Column"),
                    ),
                  ],
                  builder: (_, controller, _) {
                    return IconButton(
                      focusNode: _buttonFocusNode,
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => controller.isOpen
                          ? controller.close()
                          : controller.open(),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(widget.content),

            const SizedBox(height: 12),

            Row(
              children: [
                Text(widget.date, style: TextStyle(color: Colors.grey)),
                const Spacer(),
                Chip(label: Text(widget.priority), padding: const .all(2)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
