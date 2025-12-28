import "package:flex_color_picker/flex_color_picker.dart";
import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";

class EventCalendarScreen extends StatelessWidget {
  const EventCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Event Calendar"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_left),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_right),
                      ),
                      const Text("December 2025"),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.today_outlined),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CreateNewEventScreen(),
                            ),
                          );
                        },
                        child: const Text("New Event"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                              ),
                          itemCount: 42,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: .all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHigh,
                                ),
                              ),
                              padding: const .all(16),
                              child: Text("$index"),
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
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateNewEventScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}

class CreateNewEventScreen extends StatefulWidget {
  const CreateNewEventScreen({super.key});

  @override
  State<CreateNewEventScreen> createState() => CreateNewEventScreenState();
}

class CreateNewEventScreenState extends State<CreateNewEventScreen> {
  DateTime? _selectedDate;
  Color _eventColor = Colors.blue;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 12, 26),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

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
          appBar: AppBar(
            title: const Text("Create New Event"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: const Text("Event Title"),
                      floatingLabelBehavior: .always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: _selectDate,
                        child: const Text("Select Start Date"),
                      ),
                      OutlinedButton(
                        onPressed: _selectDate,
                        child: const Text("Select End Date"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: _openColorPicker,
                        child: const Text("Pick a Color"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Save Event"),
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
