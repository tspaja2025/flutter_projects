import "package:flutter/material.dart";
import "package:flutter_projects/screens/api_keys_screen.dart";
import "package:flutter_projects/screens/calculator_screen.dart";
import "package:flutter_projects/screens/chat_screen.dart";
import "package:flutter_projects/screens/event_calendar_screen.dart";
import "package:flutter_projects/screens/file_manager_screen.dart";
import "package:flutter_projects/screens/invoice_manager_screen.dart";
import "package:flutter_projects/screens/kanban_board_screen.dart";
import "package:flutter_projects/screens/mail_screen.dart";
import "package:flutter_projects/screens/note_taker_screen.dart";
import "package:flutter_projects/screens/qr_generator_screen.dart";
import "package:flutter_projects/screens/todo_screen.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";
import "package:flutter_projects/widgets/project_card_widget.dart";

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => DefaultScreenState();
}

class DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Projects"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const .all(16),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: 6,
                    children: [
                      ProjectCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const ApiKeysScreen(),
                            ),
                          );
                        },
                        icon: Icons.api_outlined,
                        title: "API Keys",
                        description:
                            "Manage and store your API credentials securely.",
                      ),
                      ProjectCard(
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
                      ),
                      ProjectCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        },
                        icon: Icons.chat_outlined,
                        title: "Chat",
                        description: "Real-time messaging and conversations.",
                      ),
                      ProjectCard(
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
                      ),
                      ProjectCard(
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
                      ),
                      ProjectCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) =>
                                  const InvoiceManagerScreen(),
                            ),
                          );
                        },
                        icon: Icons.receipt_outlined,
                        title: "Invoice Manager",
                        description: "Create and track invoices easily.",
                      ),
                      ProjectCard(
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
                      ),
                      ProjectCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const MailScreen(),
                            ),
                          );
                        },
                        icon: Icons.mail_outline,
                        title: "Mail",
                        description: "Manage email communication.",
                      ),
                      ProjectCard(
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
                      ),
                      ProjectCard(
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
                      ),
                      ProjectCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const TodoScreen(),
                            ),
                          );
                        },
                        icon: Icons.list_outlined,
                        title: "To Do",
                        description: "Track tasks and mark progress.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
