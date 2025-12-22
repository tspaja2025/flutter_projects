import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_projects/screens/api_keys_screen.dart";
import "package:flutter_projects/screens/chat_screen.dart";
import "package:flutter_projects/screens/event_calendar_screen.dart";
import "package:flutter_projects/screens/file_manager_screen.dart";
import "package:flutter_projects/screens/home_screen.dart";
import "package:flutter_projects/screens/invoice_manager_screen.dart";
import "package:flutter_projects/screens/kanban_board_screen.dart";
import "package:flutter_projects/screens/mail_screen.dart";
import "package:flutter_projects/screens/notes_screen.dart";
import "package:flutter_projects/screens/qr_generator_screen.dart";
import "package:flutter_projects/screens/todo_screen.dart";
import "package:flutter_projects/widgets/app_bar_actions.dart";

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<StatefulWidget> createState() => DefaultScreenState();
}

class DefaultScreenState extends State<StatefulWidget> {
  int _index = 0;
  bool _goingForward = true;

  final List<Widget> screens = [
    const HomeScreen(),
    const ApiKeyGeneratorScreen(),
    const EventCalendarScreen(),
    const ChatScreen(),
    const FileManagerScreen(),
    const InvoiceManagerScreen(),
    const KanbanBoardScreen(),
    const MailScreen(),
    const NoteTakerScreen(),
    const QrGeneratorScreen(),
    const ToDoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const NextScreenIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft):
            const PreviousScreenIntent(),
      },
      child: Actions(
        actions: {
          NextScreenIntent: CallbackAction<NextScreenIntent>(
            onInvoke: (_) {
              if (_index < screens.length - 1) {
                setState(() {
                  _goingForward = true;
                  _index++;
                });
              }
              return null;
            },
          ),
          PreviousScreenIntent: CallbackAction<PreviousScreenIntent>(
            onInvoke: (_) {
              if (_index > 0) {
                setState(() {
                  _goingForward = false;
                  _index--;
                });
              }
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                screens[_index]
                    .toString()
                    .replaceAll("Screen", "")
                    .split(RegExp(r"(?=[A-Z])"))
                    .join(" "),
              ),
              centerTitle: true,
              actions: [AppBarActions()],
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                final begin = _goingForward
                    ? const Offset(1.0, 0.0)
                    : const Offset(-1.0, 0.0);

                var tween = Tween(
                  begin: begin,
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              child: KeyedSubtree(
                key: ValueKey(_index),
                child: screens[_index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextScreenIntent extends Intent {
  const NextScreenIntent();
}

class PreviousScreenIntent extends Intent {
  const PreviousScreenIntent();
}
