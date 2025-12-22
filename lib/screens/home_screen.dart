import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<StatefulWidget> {
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

  final List<Map<String, dynamic>> projects = const [
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
    {
      "title": "Chat",
      "icon": Icons.chat_outlined,
      "description": "Real-time messaging and conversations.",
    },
    {
      "title": "File Manager",
      "icon": Icons.folder_open_outlined,
      "description": "Browse and organize your files.",
    },
    {
      "title": "Invoice Manager",
      "icon": Icons.receipt_outlined,
      "description": "Create and track invoices easily.",
    },
    {
      "title": "Kanban Board",
      "icon": Icons.view_kanban_outlined,
      "description": "Organize tasks with kanban workflows.",
    },
    {
      "title": "Mail",
      "icon": Icons.mail_outline,
      "description": "Manage email communication.",
    },
    {
      "title": "Notes",
      "icon": Icons.note_outlined,
      "description": "Create and keep all your notes.",
    },
    {
      "title": "QR Generator",
      "icon": Icons.qr_code_outlined,
      "description": "Generate custom QR codes.",
    },
    {
      "title": "To Do",
      "icon": Icons.list_outlined,
      "description": "Track tasks and mark progress.",
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
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return ProjectCard(
                          project: projects[index],
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
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isMobile;

  const ProjectCard({super.key, required this.project, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: .circular(16)),
      child: Padding(
        padding: const .all(16),
        child: isMobile ? _mobileLayout(context) : _desktopLayout(context),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        _icon(context, size: 52),
        const SizedBox(height: 20),
        _title(),
        const SizedBox(height: 8),
        _description(),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Row(
      children: [
        _icon(context, size: 44),
        const SizedBox(width: 16),
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

  Widget _icon(BuildContext context, {required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: .circular(size / 2),
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
      ),
      child: Icon(project["icon"], size: size * .55),
    );
  }

  Widget _title() {
    return Text(
      project["title"],
      style: const TextStyle(fontSize: 18, fontWeight: .w600),
    );
  }

  Widget _description({int maxLines = 3}) {
    return Text(
      project["description"],
      maxLines: maxLines,
      overflow: .ellipsis,
      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
    );
  }
}
