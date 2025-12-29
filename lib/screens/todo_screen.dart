import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  TodoView _todoView = TodoView.all;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("To Do"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "What needs to be done?",
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text("Add Task"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      SegmentedButton(
                        segments: [
                          ButtonSegment(
                            value: TodoView.all,
                            label: const Text("All"),
                          ),
                          ButtonSegment(
                            value: TodoView.active,
                            label: const Text("Active"),
                          ),
                          ButtonSegment(
                            value: TodoView.completed,
                            label: const Text("Completed"),
                          ),
                        ],
                        showSelectedIcon: false,
                        selected: {_todoView},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            _todoView = newSelection.first;
                          });
                        },
                      ),
                    ],
                  ),

                  // Empty State
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const .all(16),
                      child: Column(
                        children: [
                          Text(
                            "No tasks yet.",
                            style: TextTheme.of(context).titleLarge,
                          ),
                          const Text(
                            "Start by adding a task to get organized.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  TodoItem(title: "Learn Flutter"),
                  TodoItem(title: "Build to do app"),
                  TodoItem(title: "Write documentation"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

enum TodoView { all, active, completed }

class TodoItem extends StatefulWidget {
  final String title;

  const TodoItem({super.key, required this.title});

  @override
  State<TodoItem> createState() => TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  bool isChecked = false;

  final FocusNode _childFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        title: Text(
          widget.title,
          style: isChecked
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                )
              : null,
        ),
        subtitle: const Text(
          "Created: 29/12/2025",
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MenuAnchor(
          childFocusNode: _childFocusNode,
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              leadingIcon: const Icon(Icons.edit_outlined),
              child: const Text("Edit"),
            ),
            MenuItemButton(
              onPressed: () {},
              leadingIcon: const Icon(Icons.delete_outline),
              child: const Text("Delete"),
            ),
          ],
          builder: (context, controller, child) {
            return IconButton(
              focusNode: _childFocusNode,
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
      ),
    );
  }
}
