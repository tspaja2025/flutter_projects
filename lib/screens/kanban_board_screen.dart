import "package:flutter/material.dart";

// Missing Logic:
// Edit Column
// Edit Task

class KanbanBoardScreen extends StatefulWidget {
  const KanbanBoardScreen({super.key});

  @override
  State<KanbanBoardScreen> createState() => KanbanBoardScreenState();
}

class KanbanBoardScreenState extends State<KanbanBoardScreen> {
  final List<KanbanColumnModel> columns = [
    KanbanColumnModel(
      id: "todo",
      title: "To Do",
      tasks: [
        KanbanTask(
          id: "1",
          title: "Design System Setup",
          content: "Create a comprehensive design system...",
          date: "25/12/2025",
          priority: "High",
        ),
        KanbanTask(
          id: "2",
          title: "API Integration",
          content: "Integrate with backend APIs",
          date: "25/12/2025",
          priority: "Medium",
        ),
      ],
    ),
    KanbanColumnModel(
      id: "progress",
      title: "In Progress",
      tasks: [
        KanbanTask(
          id: "3",
          title: "User Authentication",
          content: "Implement login & signup",
          date: "25/12/2025",
          priority: "High",
        ),
      ],
    ),
    KanbanColumnModel(
      id: "review",
      title: "Review",
      tasks: [
        KanbanTask(
          id: "4",
          title: "Mobile Responsiviness",
          content: "Ensure the app works perfectly on mobile devices",
          date: "25/12/2025",
          priority: "Medium",
        ),
      ],
    ),
    KanbanColumnModel(
      id: "done",
      title: "Done",
      tasks: [
        KanbanTask(
          id: "5",
          title: "Project Setup",
          content: "Initialize Flutter project.",
          date: "25/12/2025",
          priority: "Low",
        ),
      ],
    ),
  ];

  void addColumn(String title) {
    setState(() {
      columns.add(
        KanbanColumnModel(
          id: DateTime.now().toString(),
          title: title,
          tasks: [],
        ),
      );
    });
  }

  void deleteColumn(String columnId) {
    setState(() {
      columns.removeWhere((c) => c.id == columnId);
    });
  }

  void addTask(String columnId) {
    final column = columns.firstWhere((c) => c.id == columnId);

    setState(() {
      column.tasks.add(
        KanbanTask(
          id: DateTime.now().toString(),
          title: "New Task",
          content: "Task description",
          date: "01/01/2026",
          priority: "Low",
        ),
      );
    });
  }

  void deleteTask(String columnId, String taskId) {
    final column = columns.firstWhere((c) => c.id == columnId);

    setState(() {
      column.tasks.removeWhere((t) => t.id == taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Kanban Board"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      FilledButton(
                        onPressed: () {},
                        child: const Text("Add Column"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: columns.map((column) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width - 32) / 4,
                          child: KanbanColumn(
                            title: column.title,
                            itemCount: column.tasks.length.toString(),
                            children: column.tasks.map((task) {
                              return KanbanColumnItem(
                                title: task.title,
                                content: task.content,
                                date: task.date,
                                priority: task.priority,
                                onDelete: () => deleteTask(column.id, task.id),
                              );
                            }).toList(),
                            onAddTask: () => addTask(column.id),
                            onDeleteColumn: () => deleteColumn(column.id),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Row(
                  //   crossAxisAlignment: .start,
                  //   children: [
                  //     SizedBox(
                  //       width: (MediaQuery.of(context).size.width - 32) / 4,
                  //       child: KanbanColumn(
                  //         title: "To Do",
                  //         itemCount: "2",
                  //         children: [
                  //           KanbanColumnItem(
                  //             title: "Design System Setup",
                  //             content:
                  //                 "Create a comprehensive design system with colors, typography, and components",
                  //             date: "25/12/2025",
                  //             priority: "High",
                  //           ),
                  //           KanbanColumnItem(
                  //             title: "API Integration",
                  //             content:
                  //                 "Integrate with backend APIs for data fetching",
                  //             date: "25/12/2025",
                  //             priority: "Medium",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: (MediaQuery.of(context).size.width - 32) / 4,
                  //       child: KanbanColumn(
                  //         title: "In Progress",
                  //         itemCount: "1",
                  //         children: [
                  //           KanbanColumnItem(
                  //             title: "User Authentication",
                  //             content:
                  //                 "Implement login and signup functionality",
                  //             date: "25/12/2025",
                  //             priority: "High",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: (MediaQuery.of(context).size.width - 32) / 4,
                  //       child: KanbanColumn(
                  //         title: "Review",
                  //         itemCount: "1",
                  //         children: [
                  //           KanbanColumnItem(
                  //             title: "Mobile Responsiveness",
                  //             content:
                  //                 "Ensure the app works perfectly on mobile devices",
                  //             date: "25/12/2025",
                  //             priority: "Medium",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: (MediaQuery.of(context).size.width - 32) / 4,
                  //       child: KanbanColumn(
                  //         title: "Done",
                  //         itemCount: "1",
                  //         children: [
                  //           KanbanColumnItem(
                  //             title: "Project Setup",
                  //             content:
                  //                 "Initialize Next.js project with TypeScript and Tailwind",
                  //             date: "25/12/2025",
                  //             priority: "Low",
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
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

class KanbanColumn extends StatefulWidget {
  final String title;
  final String itemCount;
  final List<Widget> children;
  final VoidCallback onAddTask;
  final VoidCallback onDeleteColumn;

  const KanbanColumn({
    super.key,
    required this.title,
    required this.itemCount,
    required this.children,
    required this.onAddTask,
    required this.onDeleteColumn,
  });

  @override
  State<KanbanColumn> createState() => KanbanColumnState();
}

class KanbanColumnState extends State<KanbanColumn> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            Row(
              spacing: 8,
              children: [
                Text(widget.title),
                Chip(padding: const .all(2), label: Text(widget.itemCount)),
                const Spacer(),
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: widget.onAddTask,
                      child: const Text("New Task"),
                    ),
                    // MenuItemButton(
                    //   onPressed: () {},
                    //   child: const Text("Edit Column"),
                    // ),
                    MenuItemButton(
                      onPressed: widget.onDeleteColumn,
                      child: const Text("Delete Column"),
                    ),
                  ],
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
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...widget.children,
          ],
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
  final VoidCallback onDelete;

  const KanbanColumnItem({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.priority,
    required this.onDelete,
  });

  @override
  State<KanbanColumnItem> createState() => KanbanColumnItemState();
}

class KanbanColumnItemState extends State<KanbanColumnItem> {
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Text(widget.title),
                const Spacer(),
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {},
                      child: const Text("Edit Task"),
                    ),
                    MenuItemButton(
                      onPressed: widget.onDelete,
                      child: const Text("Delete Task"),
                    ),
                  ],
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
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(widget.content),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(widget.date, style: const TextStyle(color: Colors.grey)),
                Chip(
                  padding: const .all(4),
                  label: Text(
                    widget.priority,
                    style: TextStyle(
                      color: widget.priority == "High"
                          ? Colors.red
                          : widget.priority == "Medium"
                          ? Colors.orange
                          : widget.priority == "Low"
                          ? Colors.blue
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KanbanTask {
  final String id;
  String title;
  String content;
  String date;
  String priority;

  KanbanTask({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.priority,
  });
}

class KanbanColumnModel {
  final String id;
  String title;
  List<KanbanTask> tasks;

  KanbanColumnModel({
    required this.id,
    required this.title,
    required this.tasks,
  });
}
