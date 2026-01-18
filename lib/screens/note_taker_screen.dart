import "package:flex_color_picker/flex_color_picker.dart";
import "package:flutter/material.dart";

// Add Logic

class NoteTakerScreen extends StatefulWidget {
  const NoteTakerScreen({super.key});

  @override
  State<NoteTakerScreen> createState() => NoteTakerScreenState();
}

class NoteTakerScreenState extends State<NoteTakerScreen> {
  NoteView _noteView = NoteView.grid;
  String? _selectedCategory;
  String? _selectedFilter = "Recently Updated";
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<Note> _notes = [
    Note(
      id: "1",
      title: "Shopping List",
      content: "Milk, Eggs, Bread, Coffee",
      category: "Personal",
      tags: ["shopping", "grocery"],
      isPinned: true,
    ),
    Note(
      id: "2",
      title: "Meeting Notes",
      content: "Discuss project timeline with team",
      category: "Work",
      tags: ["meeting", "project"],
    ),
    Note(
      id: "3",
      title: "App Idea",
      content: "Build a habit tracking app with rewards system",
      category: "Ideas",
      tags: ["app", "idea", "startup"],
    ),
  ];

  final List<Category> _categories = [
    Category(id: "1", name: "Personal", color: Color(0xFF2196F3)),
    Category(id: "2", name: "Work", color: Color(0xFF9C27B0)),
    Category(id: "3", name: "Ideas", color: Color(0xFF4CAF50)),
  ];

  void _addNote(Note note) {
    setState(() {
      _notes.insert(0, note);
    });
  }

  void _updateNote(String id, Note updatedNote) {
    setState(() {
      final index = _notes.indexWhere((note) => note.id == id);
      if (index != -1) {
        _notes[index] = updatedNote;
      }
    });
  }

  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
  }

  void _togglePinNote(String id) {
    setState(() {
      final index = _notes.indexWhere((note) => note.id == id);
      if (index != -1) {
        _notes[index] = _notes[index].copyWith(
          isPinned: !_notes[index].isPinned,
          updatedAt: DateTime.now(),
        );
      }
    });
  }

  void _addCategory(Category category) {
    setState(() {
      _categories.add(category);
    });
  }

  void _deleteCategory(String id) {
    setState(() {
      _categories.removeWhere((category) => category.id == id);
    });
  }

  List<Note> _getFilteredNotes() {
    List<Note> filtered = List.from(_notes);

    // Search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((note) {
        final query = _searchQuery.toLowerCase();
        return note.title.toLowerCase().contains(query) ||
            note.content.toLowerCase().contains(query) ||
            note.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    // Category filter
    if (_selectedCategory != null && _selectedCategory != "All Categories") {
      filtered = filtered
          .where((note) => note.category == _selectedCategory)
          .toList();
    }

    // Sorting
    filtered.sort((a, b) {
      switch (_selectedFilter) {
        case "Recently Updated":
          return b.updatedAt.compareTo(a.updatedAt);
        case "Recently Created":
          return b.createdAt.compareTo(a.createdAt);
        case "Title (A-Z)":
          return a.title.compareTo(b.title);
        case "Category":
          return a.category.compareTo(b.category);
        default:
          return b.updatedAt.compareTo(a.updatedAt);
      }
    });

    // Pinned notes to top
    filtered.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return 0;
    });

    return filtered;
  }

  void _showDeleteNoteDialog(String noteId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Note"),
          content: const Text("Are you sure you want to delete this note?"),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                _deleteNote(noteId);
                Navigator.pop(context);
              },
              child: const Text("Delete Note"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteCategoryDialog(String categoryId, String categoryName) {
    // Check if any notes use this category
    final notesUsingCategory = _notes
        .where((note) => note.category == categoryName)
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you sure you want to delete the '$categoryName' category?",
              ),
              if (notesUsingCategory.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  "Warning: ${notesUsingCategory.length} note(s) use this category. They will be moved to 'Personal' category.",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                if (notesUsingCategory.isNotEmpty) {
                  // Update notes to use "Personal" category
                  for (final note in notesUsingCategory) {
                    _updateNote(note.id, note.copyWith(category: "Personal"));
                  }
                }
                _deleteCategory(categoryId);
                Navigator.pop(context);
              },
              child: const Text("Delete Category"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredNotes = _getFilteredNotes();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Note Taker"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Search and Filter Row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Search notes...",
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      DropdownMenu<String>(
                        initialSelection: _selectedCategory ?? "All Categories",
                        label: const Text("Category"),
                        onSelected: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        dropdownMenuEntries: [
                          const DropdownMenuEntry(
                            value: "All Categories",
                            label: "All Categories",
                          ),
                          ..._categories.map((category) {
                            return DropdownMenuEntry(
                              value: category.name,
                              label: category.name,
                            );
                          }),
                        ],
                      ),
                      const SizedBox(width: 8),
                      DropdownMenu<String>(
                        initialSelection: _selectedFilter,
                        label: const Text("Filter By"),
                        onSelected: (value) {
                          setState(() {
                            _selectedFilter = value;
                          });
                        },
                        dropdownMenuEntries: filterByList.map((filter) {
                          return DropdownMenuEntry(
                            value: filter,
                            label: filter,
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 8),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          _noteView == NoteView.grid
                              ? Icons.view_list
                              : Icons.grid_view,
                        ),
                        onPressed: () {
                          setState(() {
                            _noteView = _noteView == NoteView.grid
                                ? NoteView.list
                                : NoteView.grid;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      MenuAnchor(
                        menuChildren: [
                          MenuItemButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewNoteScreen(
                                    categories: _categories,
                                    onSave: _addNote,
                                  ),
                                ),
                              );
                            },
                            child: const Text("New Note"),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewCategoryScreen(
                                    categories: _categories,
                                    onSave: _addCategory,
                                    onDelete: (category) {
                                      _showDeleteCategoryDialog(
                                        category.id,
                                        category.name,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            child: const Text("New Category"),
                          ),
                        ],
                        builder: (context, controller, child) {
                          return FilledButton.icon(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add"),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Notes List/Grid
                  if (filteredNotes.isEmpty)
                    // Empty state
                    Expanded(
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "No notes found.",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _searchQuery.isEmpty &&
                                          _selectedCategory == null
                                      ? "Create your first note to get started."
                                      : "No notes match your search criteria.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 16),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewNoteScreen(
                                          categories: _categories,
                                          onSave: _addNote,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Create your first note"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: _noteView == NoteView.grid
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width /
                                        (MediaQuery.of(context).size.height /
                                            1.0),
                                    mainAxisExtent: 180,
                                  ),
                              itemCount: filteredNotes.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 300,
                                  child: NoteItem(
                                    note: filteredNotes[index],
                                    onEdit: (note) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewNoteScreen(
                                            categories: _categories,
                                            note: note,
                                            onSave: (updatedNote) {
                                              _updateNote(note.id, updatedNote);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    onDelete: () {
                                      _showDeleteNoteDialog(
                                        filteredNotes[index].id,
                                      );
                                    },
                                    onTogglePin: () {
                                      _togglePinNote(filteredNotes[index].id);
                                    },
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: filteredNotes.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: NoteItem(
                                    note: filteredNotes[index],
                                    onEdit: (note) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewNoteScreen(
                                            categories: _categories,
                                            note: note,
                                            onSave: (updatedNote) {
                                              _updateNote(note.id, updatedNote);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    onDelete: () {
                                      _showDeleteNoteDialog(
                                        filteredNotes[index].id,
                                      );
                                    },
                                    onTogglePin: () {
                                      _togglePinNote(filteredNotes[index].id);
                                    },
                                  ),
                                );
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("What do you want to add?"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewNoteScreen(
                                        categories: _categories,
                                        onSave: _addNote,
                                      ),
                                    ),
                                  );
                                },
                                leading: const Icon(Icons.note_outlined),
                                title: const Text("New Note"),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewCategoryScreen(
                                        categories: _categories,
                                        onSave: _addCategory,
                                        onDelete: (_) {},
                                      ),
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
}

const List<String> categoryList = <String>[
  "All Categories",
  "Personal",
  "Work",
  "Ideas",
];

class NoteItem extends StatelessWidget {
  final Note note;
  final Function(Note) onEdit;
  final Function() onDelete;
  final Function() onTogglePin;

  const NoteItem({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
    required this.onTogglePin,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return "${difference.inMinutes}m ago";
      }
      return "${difference.inHours}h ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = note.color;

    return Card(
      color: note.color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (note.isPinned)
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(Icons.push_pin, size: 16),
                        ),
                      Expanded(
                        child: Text(
                          note.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {
                        onTogglePin();
                      },
                      leadingIcon: Icon(
                        note.isPinned
                            ? Icons.push_pin
                            : Icons.push_pin_outlined,
                      ),
                      child: Text(note.isPinned ? "Unpin" : "Pin"),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        onEdit(note);
                      },
                      leadingIcon: const Icon(Icons.edit_outlined),
                      child: const Text("Edit"),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        onDelete();
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
              ],
            ),
            const SizedBox(height: 8),
            Text(
              note.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Chip(
                  backgroundColor: categoryColor.withValues(alpha: 0.2),
                  label: Text(
                    note.category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: categoryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ...note.tags.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Chip(
                      padding: const EdgeInsets.all(2),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      label: Text(tag, style: const TextStyle(fontSize: 10)),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Updated: ${_formatDate(note.updatedAt)}",
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewNoteScreen extends StatefulWidget {
  final List<Category> categories;
  final Note? note;
  final Function(Note) onSave;

  const NewNoteScreen({
    super.key,
    required this.categories,
    this.note,
    required this.onSave,
  });

  @override
  State<NewNoteScreen> createState() => NewNoteScreenState();
}

class NewNoteScreenState extends State<NewNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagsController;
  late String _selectedCategory;
  late Color _selectedColor;
  late bool _isPinned;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? "");
    _contentController = TextEditingController(
      text: widget.note?.content ?? "",
    );
    _tagsController = TextEditingController(
      text: widget.note?.tags.join(", ") ?? "",
    );
    _selectedCategory =
        widget.note?.category ??
        (widget.categories.isNotEmpty
            ? widget.categories.first.name
            : "Personal");
    _selectedColor =
        widget.note?.color ??
        widget.categories
            .firstWhere(
              (c) => c.name == _selectedCategory,
              orElse: () => widget.categories.first,
            )
            .color;
    _isPinned = widget.note?.isPinned ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final tags = _tagsController.text
          .split(",")
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      final note = Note(
        id: widget.note?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _contentController.text,
        category: _selectedCategory,
        tags: tags,
        color: _selectedColor,
        isPinned: _isPinned,
        createdAt: widget.note?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      widget.onSave(note);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.note == null ? "New Note" : "Edit Note"),
            centerTitle: true,
            actions: [
              Switch.adaptive(
                value: _isPinned,
                onChanged: (value) {
                  setState(() {
                    _isPinned = value;
                  });
                },
              ),
              const SizedBox(width: 8),
              IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: isLargeScreen ? 600 : double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Title"),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter title",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a title";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              DropdownMenu<String>(
                                width: double.infinity,
                                initialSelection: _selectedCategory,
                                label: const Text("Category"),
                                onSelected: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedCategory = value;
                                      final category = widget.categories
                                          .firstWhere(
                                            (c) => c.name == value,
                                            orElse: () =>
                                                widget.categories.first,
                                          );
                                      _selectedColor = category.color;
                                    });
                                  }
                                },
                                dropdownMenuEntries: widget.categories.map((
                                  category,
                                ) {
                                  return DropdownMenuEntry(
                                    value: category.name,
                                    label: category.name,
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _tagsController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Tags (comma-separated)"),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "tag1, tag2, tag3",
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _contentController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Content"),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter note content",
                                ),
                                maxLines: 10,
                                minLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter content";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: _selectedColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black26),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Note Color",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge,
                                  ),
                                  const Spacer(),
                                  FilledButton(
                                    onPressed: () async {
                                      final color = await showDialog<Color>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Select Color"),
                                            content: ColorPicker(
                                              color: _selectedColor,
                                              onColorChanged: (Color color) {
                                                _selectedColor = color;
                                              },
                                              pickersEnabled:
                                                  const <ColorPickerType, bool>{
                                                    ColorPickerType.both: false,
                                                    ColorPickerType.primary:
                                                        false,
                                                    ColorPickerType.accent:
                                                        false,
                                                    ColorPickerType.bw: false,
                                                    ColorPickerType.custom:
                                                        true,
                                                    ColorPickerType.wheel:
                                                        false,
                                                  },
                                              width: 40,
                                              height: 40,
                                              spacing: 5,
                                              runSpacing: 5,
                                              borderRadius: 0,
                                              colorCodeHasColor: true,
                                              pickerTypeTextStyle:
                                                  const TextStyle(fontSize: 12),
                                              selectedPickerTypeColor: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                            actions: [
                                              OutlinedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel"),
                                              ),
                                              FilledButton(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  _selectedColor,
                                                ),
                                                child: const Text("Select"),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (color != null) {
                                        setState(() {
                                          _selectedColor = color;
                                        });
                                      }
                                    },
                                    child: const Text("Change Color"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  const SizedBox(width: 8),
                                  FilledButton(
                                    onPressed: _saveNote,
                                    child: Text(
                                      widget.note == null
                                          ? "Create Note"
                                          : "Update Note",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NewCategoryScreen extends StatefulWidget {
  final List<Category> categories;
  final Function(Category) onSave;
  final Function(Category) onDelete;

  const NewCategoryScreen({
    super.key,
    required this.categories,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<NewCategoryScreen> createState() => NewCategoryScreenState();
}

class NewCategoryScreenState extends State<NewCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Color _selectedColor = Colors.blue;
  bool _isEditing = false;
  String? _editingCategoryId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _openColorPicker() async {
    final color = await showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Color"),
          content: ColorPicker(
            color: _selectedColor,
            onColorChanged: (Color color) {
              _selectedColor = color;
            },
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
              ColorPickerType.bw: false,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: false,
            },
            width: 40,
            height: 40,
            spacing: 5,
            runSpacing: 5,
            borderRadius: 0,
            colorCodeHasColor: true,
            pickerTypeTextStyle: const TextStyle(fontSize: 12),
            selectedPickerTypeColor: Theme.of(context).primaryColor,
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, _selectedColor),
              child: const Text("Select"),
            ),
          ],
        );
      },
    );

    if (color != null) {
      setState(() {
        _selectedColor = color;
      });
    }
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;

      // Check for duplicate names (excluding the one being edited)
      if (widget.categories.any(
        (c) =>
            c.name.toLowerCase() == name.toLowerCase() &&
            (!_isEditing || c.id != _editingCategoryId),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Category '$name' already exists"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final category = Category(
        id: _isEditing
            ? _editingCategoryId!
            : DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        color: _selectedColor,
      );

      widget.onSave(category);

      if (_isEditing) {
        Navigator.pop(context);
      } else {
        _nameController.clear();
        setState(() {
          _selectedColor = Colors.blue;
          _isEditing = false;
          _editingCategoryId = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Category created successfully")),
        );
      }
    }
  }

  void _editCategory(Category category) {
    setState(() {
      _isEditing = true;
      _editingCategoryId = category.id;
      _nameController.text = category.name;
      _selectedColor = category.color;
    });
  }

  void _deleteCategory(String id) {
    setState(() {
      widget.categories.removeWhere((category) => category.id == id);
    });
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
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Category Name"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Enter category name",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a category name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: _openColorPicker,
                              child: const Text("Select Category Color"),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: _selectedColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black26),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _selectedColor.value
                                      .toRadixString(16)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (_isEditing)
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isEditing = false;
                                        _editingCategoryId = null;
                                        _nameController.clear();
                                        _selectedColor = Colors.blue;
                                      });
                                    },
                                    child: const Text("Cancel Edit"),
                                  ),
                                const SizedBox(width: 8),
                                FilledButton(
                                  onPressed: _saveCategory,
                                  child: Text(
                                    _isEditing
                                        ? "Update Category"
                                        : "Create Category",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Existing Categories",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.categories.length,
                            itemBuilder: (context, index) {
                              final category = widget.categories[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  leading: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: category.color,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black26),
                                    ),
                                  ),
                                  title: Text(category.name),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _editCategory(category);
                                        },
                                        icon: const Icon(Icons.edit_outlined),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Delete Category",
                                                ),
                                                content: Text(
                                                  "Are you sure you want to delete the '${category.name}' category?",
                                                ),
                                                actions: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  FilledButton(
                                                    onPressed: () {
                                                      // This should be handled by the parent widget
                                                      Navigator.pop(context);
                                                      _deleteCategory(
                                                        category.id,
                                                      );
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "${category.name} Deleted",
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.delete_outline),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

const List<String> filterByList = <String>[
  "Recently Updated",
  "Recently Created",
  "Title (A-Z)",
  "Category",
];

enum NoteView { grid, list }

class Note {
  final String id;
  String title;
  String content;
  String category;
  List<String> tags;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPinned;
  Color color;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.tags = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isPinned = false,
    Color? color,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now(),
       color = color ?? Color(0xFF2196F3);

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    Color? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      color: color ?? this.color,
    );
  }
}

class Category {
  final String id;
  String name;
  Color color;

  Category({required this.id, required this.name, required this.color});

  Category copyWith({String? id, String? name, Color? color}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}
