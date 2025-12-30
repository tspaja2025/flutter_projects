import "package:flex_color_picker/flex_color_picker.dart";
import "package:flutter/material.dart";

class NoteTakerScreen extends StatefulWidget {
  const NoteTakerScreen({super.key});

  @override
  State<NoteTakerScreen> createState() => NoteTakerScreenState();
}

class NoteTakerScreenState extends State<NoteTakerScreen> {
  NoteView _noteView = NoteView.grid;

  final FocusNode _newItemNode = FocusNode(debugLabel: "Menu Button");
  final FocusNode _exportNode = FocusNode(debugLabel: "Menu Button");
  final String _categoryValue = categoryList.first;
  final String _filterByValue = filterByList.first;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Note Taker"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  _buildActionsRow(),

                  // Empty state
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const .all(16),
                      child: Column(
                        children: [
                          Text(
                            "No notes yet.",
                            style: TextTheme.of(context).titleLarge,
                          ),
                          const Text(
                            "Create your first note to get started.",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const NewNoteScreen(),
                                ),
                              );
                            },
                            child: const Text("Create your first note"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      NoteItem(title: "Note Title", content: "Note Content"),
                      NoteItem(title: "Note Title 1", content: "Note Content"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("What do you want to add?"),
                    content: Column(
                      mainAxisSize: .min,
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NewNoteScreen(),
                              ),
                            );
                          },
                          leading: const Icon(Icons.note_outlined),
                          title: const Text("New Note"),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NewCategoryScreen(),
                              ),
                            );
                          },
                          leading: const Icon(Icons.category_outlined),
                          title: const Text("New Category"),
                        ),
                      ],
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildActionsRow() {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search notes...",
            ),
          ),
        ),
        DropdownMenu(
          initialSelection: _categoryValue,
          label: const Text("Category"),
          dropdownMenuEntries: [
            DropdownMenuEntry(value: "All Categories", label: "All Categories"),
            DropdownMenuEntry(value: "Personal", label: "Personal"),
            DropdownMenuEntry(value: "Work", label: "Work"),
            DropdownMenuEntry(value: "Ideas", label: "Ideas"),
          ],
        ),
        DropdownMenu(
          initialSelection: _filterByValue,
          label: const Text("Filter By"),
          dropdownMenuEntries: [
            DropdownMenuEntry(
              value: "Recently Updated",
              label: "Recently Updated",
            ),
            DropdownMenuEntry(
              value: "Recently Created",
              label: "Recently Created",
            ),
            DropdownMenuEntry(value: "Title (A-Z)", label: "Title (A-Z)"),
            DropdownMenuEntry(value: "Category", label: "Category"),
          ],
        ),
        const Spacer(),
        SegmentedButton(
          segments: [
            ButtonSegment(
              value: NoteView.grid,
              icon: const Icon(Icons.grid_3x3_outlined),
            ),
            ButtonSegment(
              value: NoteView.list,
              icon: const Icon(Icons.list_outlined),
            ),
          ],
          showSelectedIcon: false,
          selected: {_noteView},
          onSelectionChanged: (newSelection) {
            setState(() {
              _noteView = newSelection.first;
            });
          },
        ),
        MenuAnchor(
          childFocusNode: _exportNode,
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              child: const Text("Export as JSON"),
            ),
            MenuItemButton(
              onPressed: () {},
              child: const Text("Export as Text"),
            ),
          ],
          builder: (context, controller, child) {
            return IconButton(
              focusNode: _exportNode,
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(Icons.download_outlined),
            );
          },
        ),
        MenuAnchor(
          childFocusNode: _newItemNode,
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NewNoteScreen(),
                  ),
                );
              },
              child: const Text("New Note"),
            ),
            MenuItemButton(onPressed: () {}, child: const Text("New Category")),
          ],
          builder: (context, controller, child) {
            return IconButton(
              focusNode: _newItemNode,
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
    );
  }
}

const List<String> categoryList = <String>[
  "All Categories",
  "Personal",
  "Work",
  "Ideas",
];
const List<String> filterByList = <String>[
  "Recently Updated",
  "Recently Created",
  "Title (A-Z)",
  "Category",
];

enum NoteView { grid, list }

class NoteItem extends StatefulWidget {
  final String title;
  final String content;

  const NoteItem({super.key, required this.title, required this.content});

  @override
  State<NoteItem> createState() => NoteItemState();
}

class NoteItemState extends State<NoteItem> {
  final FocusNode _childFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 312,
      child: Card(
        child: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(widget.title, style: TextTheme.of(context).titleMedium),
                  MenuAnchor(
                    childFocusNode: _childFocusNode,
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: const Icon(Icons.push_pin_outlined),
                        child: const Text("Pin"),
                      ),
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
                ],
              ),

              const SizedBox(height: 16),
              Text(widget.content),

              const SizedBox(height: 24),
              Row(
                spacing: 8,
                children: [
                  Chip(
                    padding: const .all(4),
                    labelPadding: const .symmetric(horizontal: 2),
                    backgroundColor: Colors.blue,
                    label: const Text(
                      "Personal",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: .bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Chip(
                    padding: const .all(4),
                    labelPadding: const .symmetric(horizontal: 2),
                    label: const Text("Tag 2", style: TextStyle(fontSize: 10)),
                  ),
                  Chip(
                    padding: const .all(4),
                    labelPadding: const .symmetric(horizontal: 2),
                    label: const Text("Tag 3", style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  State<NewNoteScreen> createState() => NewNoteScreenState();
}

class NewNoteScreenState extends State<NewNoteScreen> {
  final String _categoryValue = categoryList.first;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("New Note"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 312,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: const Text("Title"),
                                  floatingLabelBehavior: .always,
                                  hintText: "Enter title",
                                ),
                              ),
                              const SizedBox(height: 16),
                              DropdownMenu(
                                width: double.infinity,
                                initialSelection: _categoryValue,
                                label: const Text("Category"),
                                dropdownMenuEntries: [
                                  DropdownMenuEntry(
                                    value: "All Categories",
                                    label: "All Categories",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Personal",
                                    label: "Personal",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Work",
                                    label: "Work",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Ideas",
                                    label: "Ideas",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: const Text("Tags (comma-separated)"),
                                  floatingLabelBehavior: .always,
                                  hintText: "tag1,tag2,tag3,",
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: const Text("Content"),
                                  floatingLabelBehavior: .always,
                                  hintText: "Enter note content",
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Create Note"),
                              ),
                            ],
                          ),
                        ),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.save_outlined),
                ),
        );
      },
    );
  }
}

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  State<NewCategoryScreen> createState() => NewCategoryScreenState();
}

class NewCategoryScreenState extends State<NewCategoryScreen> {
  Color _eventColor = Colors.blue;

  Future<void> _openColorPicker() async {
    bool pickedColor = await ColorPicker(
      color: _eventColor,
      onColorChanged: (Color color) {
        setState(() {
          _eventColor = color;
        });
      },
    ).showPickerDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("New Category"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 312,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: const Text("Category Name"),
                                  floatingLabelBehavior: .always,
                                  hintText: "Enter category name",
                                ),
                              ),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: _openColorPicker,
                                child: const Text("Category Color"),
                              ),

                              const SizedBox(height: 16),
                              const Text("Categories"),
                              const SizedBox(height: 8),
                              Card.outlined(
                                child: ListTile(
                                  contentPadding: const .symmetric(
                                    horizontal: 16,
                                  ),
                                  leading: Badge(backgroundColor: Colors.blue),
                                  title: const Text("Personal"),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ),
                              ),
                              Card.outlined(
                                child: ListTile(
                                  contentPadding: const .symmetric(
                                    horizontal: 16,
                                  ),
                                  leading: Badge(
                                    backgroundColor: Colors.purple,
                                  ),
                                  title: const Text("Work"),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ),
                              ),
                              Card.outlined(
                                child: ListTile(
                                  contentPadding: const .symmetric(
                                    horizontal: 16,
                                  ),
                                  leading: Badge(backgroundColor: Colors.green),
                                  title: const Text("Ideas"),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Create Category"),
                              ),
                            ],
                          ),
                        ),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.save_outlined),
                ),
        );
      },
    );
  }
}
