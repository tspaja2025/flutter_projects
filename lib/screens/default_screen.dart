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
import "package:flutter_projects/widgets/card_list_tile_widget.dart";

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
        return Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Projects"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: [
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const ApiKeysScreen(),
                            ),
                          );
                        },
                        icon: Icons.api_outlined,
                        title: "API Keys",
                        subtitle: "Manage and store your API credentials.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const CalculatorScreen(),
                            ),
                          );
                        },
                        icon: Icons.calculate_outlined,
                        title: "Calculator",
                        subtitle: "Calculate expressions.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        },
                        icon: Icons.chat_outlined,
                        title: "Chat",
                        subtitle: "Real-time messaging and conversations.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const EventCalendarScreen(),
                            ),
                          );
                        },
                        icon: Icons.calendar_today_outlined,
                        title: "Event Calendar",
                        subtitle: "Schedule and manage important events.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const FileManagerScreen(),
                            ),
                          );
                        },
                        icon: Icons.folder_outlined,
                        title: "File Manager",
                        subtitle: "Browse and organize your files.",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: [
                      CardListTile(
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
                        subtitle: "Create and track invoices easily.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const KanbanBoardScreen(),
                            ),
                          );
                        },
                        icon: Icons.view_kanban_outlined,
                        title: "Kanban Board",
                        subtitle: "Organize tasks with kanban workflows.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const MailScreen(),
                            ),
                          );
                        },
                        icon: Icons.mail_outline,
                        title: "Mail",
                        subtitle: "Manage email communication.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const NoteTakerScreen(),
                            ),
                          );
                        },
                        icon: Icons.sticky_note_2_outlined,
                        title: "Note Taker",
                        subtitle: "Create and keep all your notes.",
                      ),
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const QrGeneratorScreen(),
                            ),
                          );
                        },
                        icon: Icons.qr_code_outlined,
                        title: "QR Generator",
                        subtitle: "Generate custom QR code.",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: [
                      CardListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const TodoScreen(),
                            ),
                          );
                        },
                        icon: Icons.list_outlined,
                        title: "To Do",
                        subtitle: "Track tasks and mark progress.",
                      ),
                      CardListTile(
                        onTap: () {},
                        icon: Icons.report_problem_outlined,
                        title: "-",
                        subtitle: "-",
                      ),
                      CardListTile(
                        onTap: () {},
                        icon: Icons.report_problem_outlined,
                        title: "-",
                        subtitle: "-",
                      ),
                      CardListTile(
                        onTap: () {},
                        icon: Icons.report_problem_outlined,
                        title: "-",
                        subtitle: "-",
                      ),
                      CardListTile(
                        onTap: () {},
                        icon: Icons.report_problem_outlined,
                        title: "-",
                        subtitle: "-",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
