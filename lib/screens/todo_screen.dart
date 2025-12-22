import "package:flutter/material.dart";

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<StatefulWidget> createState() => ToDoScreenState();
}

class ToDoScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "What needs to be done?",
                ),
              ),
              const SizedBox(height: 12),
              TodoItem(title: "Learn Flutter"),
              TodoItem(title: "Build To Do App"),
              TodoItem(title: "Write Documentation"),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final String title;

  const TodoItem({super.key, required this.title});

  @override
  State<TodoItem> createState() => TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  bool _isChecked = false;

  final FocusNode _buttonFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const .symmetric(horizontal: 16),
        leading: Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
        title: Text(widget.title),
        subtitle: const Text(
          "Created: 20/12/2025",
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MenuAnchor(
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
                      title: const Text("Delete Todo Item"),
                      content: const Text(
                        "Are you sure you want to delete this todo item?",
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
                                content: const Text("Todo Item Deleted"),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Delete"),
            ),
          ],
          builder: (_, controller, _) {
            return IconButton(
              focusNode: _buttonFocusNode,
              icon: const Icon(Icons.more_vert),
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
            );
          },
        ),
      ),
    );
  }
}
