import "package:flutter/material.dart";
import "package:flutter_projects/screens/api_keys_screen.dart";
import "package:flutter_projects/screens/calculator_screen.dart";
import "package:flutter_projects/screens/chat_screen.dart";
import "package:flutter_projects/screens/event_calendar_screen.dart";
import "package:flutter_projects/screens/file_manager_screen.dart";
import "package:flutter_projects/screens/invoice_manager_screen.dart";
import "package:flutter_projects/screens/kanban_board_screen.dart";
import "package:flutter_projects/screens/mail_screen.dart";
import "package:flutter_projects/screens/miscellanious_screen.dart";
import "package:flutter_projects/screens/note_taker_screen.dart";
import "package:flutter_projects/screens/qr_generator_screen.dart";
import "package:flutter_projects/screens/todo_screen.dart";
import "package:flutter_projects/widgets/project_card_widget.dart";

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => DefaultScreenState();
}

class DefaultScreenState extends State<DefaultScreen> {
  int _columnCount(double width) {
    if (width >= 1400) return 4; // Large desktop
    if (width >= 1100) return 3; // Desktop
    if (width >= 700) return 2; // Tablet
    return 1; // Mobile
  }

  late final List<ProjectItem> _projects = [
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (context) => const ApiKeysScreen()),
        );
      },
      icon: Icons.api_outlined,
      title: "API Keys",
      description: "Manage and store your API credentials.",
      itemCount: "1",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const CalculatorScreen(),
          ),
        );
      },
      icon: Icons.calculate_outlined,
      title: "Calculator",
      description: "Calculate expressions.",
      itemCount: "2",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (context) => const ChatScreen()),
        );
      },
      icon: Icons.chat_outlined,
      title: "Chat",
      description: "Real-time messaging and conversations.",
      itemCount: "3",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const EventCalendarScreen(),
          ),
        );
      },
      icon: Icons.calendar_today_outlined,
      title: "Event Calendar",
      description: "Schedule and manage important events.",
      itemCount: "4",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const FileManagerScreen(),
          ),
        );
      },
      icon: Icons.folder_outlined,
      title: "File Manager",
      description: "Browse and organize your files.",
      itemCount: "5",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const InvoiceManagerScreen(),
          ),
        );
      },
      icon: Icons.receipt_outlined,
      title: "Invoice Manager",
      description: "Create and track invoices easily.",
      itemCount: "6",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const KanbanBoardScreen(),
          ),
        );
      },
      icon: Icons.view_kanban_outlined,
      title: "Kanban Board",
      description: "Organize tasks with kanban workflows.",
      itemCount: "7",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (context) => const MailScreen()),
        );
      },
      icon: Icons.mail_outline,
      title: "Mail",
      description: "Manage email communication.",
      itemCount: "8",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const MiscellaniousScreen(),
          ),
        );
      },
      icon: Icons.qr_code_outlined,
      title: "Miscellanious",
      description: "Miscellanious stuff.",
      itemCount: "9",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const NoteTakerScreen(),
          ),
        );
      },
      icon: Icons.sticky_note_2_outlined,
      title: "Note Taker",
      description: "Create and keep all your notes.",
      itemCount: "10",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const QrGeneratorScreen(),
          ),
        );
      },
      icon: Icons.qr_code_outlined,
      title: "QR Generator",
      description: "Generate custom QR code.",
      itemCount: "11",
    ),
    ProjectItem(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (context) => const TodoScreen()),
        );
      },
      icon: Icons.list_outlined,
      title: "To Do",
      description: "Track tasks and mark progress.",
      itemCount: "12",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Projects"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final columns = _columnCount(constraints.maxWidth);

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      childAspectRatio:
                          312 / 280, // match your card proportions
                    ),
                    itemCount: _projects.length,
                    itemBuilder: (context, index) {
                      final project = _projects[index];
                      return ProjectCard(
                        onTap: project.onTap,
                        icon: project.icon,
                        title: project.title,
                        description: project.description,
                        itemCount: project.itemCount,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProjectItem {
  final String title;
  final String description;
  final String itemCount;
  final IconData icon;
  final VoidCallback onTap;

  ProjectItem({
    required this.title,
    required this.description,
    required this.itemCount,
    required this.icon,
    required this.onTap,
  });
}
