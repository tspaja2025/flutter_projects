import "package:flutter/material.dart";

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  TodoView _todoView = TodoView.all;

  final List<Todo> _todos = [];
  final TextEditingController _inputController = TextEditingController();

  List<Todo> get _filteredTodos {
    switch (_todoView) {
      case TodoView.active:
        return _todos.where((t) => !t.completed).toList();
      case TodoView.completed:
        return _todos.where((t) => t.completed).toList();
      case TodoView.all:
      default:
        return _todos;
    }
  }

  void _addTask(String title) {
    if (title.trim().isEmpty) return;

    setState(() {
      _todos.add(
        Todo(
          id: DateTime.now().toIso8601String(),
          title: title,
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("To Do"), centerTitle: true),
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
                          controller: _inputController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "What needs to be done?",
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          _addTask(_inputController.text);
                          _inputController.clear();
                        },
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

                  const SizedBox(height: 16),

                  if (_filteredTodos.isEmpty)
                    // Empty State
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
                    )
                  else
                    ..._filteredTodos.map(
                      (todo) => TodoItem(
                        todo: todo,
                        onToggle: () {
                          setState(() => todo.completed = !todo.completed);
                        },
                        onDelete: () {
                          setState(
                            () => _todos.removeWhere((t) => t.id == todo.id),
                          );
                        },
                        onEdit: (newTitle) {
                          setState(() => todo.title = newTitle);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    _addTask(_inputController.text);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}

enum TodoView { all, active, completed }

class TodoItem extends StatefulWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(String) onEdit;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<TodoItem> createState() => TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  void _showEditDialog() {
    final TextEditingController controller = TextEditingController(
      text: widget.todo.title,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Task"),
        content: TextField(controller: controller),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              widget.onEdit(controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: widget.todo.completed,
          onChanged: (_) => widget.onToggle(),
        ),
        title: Text(
          widget.todo.title,
          style: widget.todo.completed
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                )
              : null,
        ),
        subtitle: Text(
          "Created: ${widget.todo.createdAt.day}/${widget.todo.createdAt.month}/${widget.todo.createdAt.year}",
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MenuAnchor(
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                Navigator.pop(context);
                _showEditDialog();
              },
              leadingIcon: const Icon(Icons.edit_outlined),
              child: const Text("Edit"),
            ),
            MenuItemButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onDelete();
              },
              leadingIcon: const Icon(Icons.delete_outline),
              child: const Text("Delete"),
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
      ),
    );
  }
}

class Todo {
  final String id;
  String title;
  bool completed;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.completed = false,
    required this.createdAt,
  });
}
