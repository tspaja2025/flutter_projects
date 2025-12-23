import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions.dart";

class NoteTakerScreen extends StatefulWidget {
  const NoteTakerScreen({super.key});

  @override
  State<StatefulWidget> createState() => NoteTakerScreenState();
}

class NoteTakerScreenState extends State<StatefulWidget> {
  int getCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  double getAspectRatio(double width) {
    if (width >= 1200) return 1.1;
    if (width >= 900) return 1.0;
    if (width >= 600) return 1.2;
    return 2.8; // list-style cards on mobile
  }

  final List<Map<String, dynamic>> notes = const [
    {
      "title": "API Keys",
      "icon": Icons.api_outlined,
      "description": "Manage and store your API credentials securely.",
    },
    {
      "title": "Calendar",
      "icon": Icons.calendar_today_outlined,
      "description": "Schedule and manage important events.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Determine number of columns based on width
                    final width = constraints.maxWidth;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: getCrossAxisCount(width),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: getAspectRatio(width),
                      ),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return NoteItem(
                          note: notes[index],
                          isMobile: width < 600,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const CreateNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Map<String, dynamic> note;
  final bool isMobile;

  const NoteItem({super.key, required this.note, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: const Text("Task Clicked")));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
        child: Padding(
          padding: const .all(16),
          child: isMobile ? _mobileLayout(context) : _desktopLayout(context),
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [_title(), const SizedBox(height: 8), _description()],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .center,
            children: [
              _title(),
              const SizedBox(height: 4),
              _description(maxLines: 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Text(
      note["title"],
      style: const TextStyle(fontSize: 18, fontWeight: .w600),
    );
  }

  Widget _description({int maxLines = 3}) {
    return Text(
      note["description"],
      maxLines: maxLines,
      overflow: .ellipsis,
      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
    );
  }
}

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => CreateNoteScreenState();
}

class CreateNoteScreenState extends State<CreateNoteScreen> {
  String categoryValue = categories.first;

  static final List<MenuEntry> categoryList = UnmodifiableListView<MenuEntry>(
    categories.map<MenuEntry>(
      (String name) => MenuEntry(value: name, label: name),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Note"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: .always,
                  label: const Text("Title"),
                  hintText: "Enter title",
                ),
              ),
              const SizedBox(height: 16),
              DropdownMenu(
                width: double.infinity,
                initialSelection: categories.first,
                label: const Text("Select Category"),
                onSelected: (String? value) {
                  setState(() {
                    categoryValue = value!;
                  });
                },
                dropdownMenuEntries: categoryList,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: .always,
                  label: const Text("Tags"),
                  hintText: "tag1,tag2,tag3",
                  helperText: "comma-separated",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: .always,
                  label: const Text("Content"),
                  hintText: "Enter note content",
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

typedef MenuEntry = DropdownMenuEntry<String>;

const List<String> categories = ["Personal", "Work", "Ideas"];
