import "package:flutter/material.dart";

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => EventCalendarScreenState();
}

class EventCalendarScreenState extends State<EventCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Event Calendar"),
            centerTitle: true,
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
                            return GestureDetector(
                              // TODO: Troubleshoot onTap behaviour
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EventItemListScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: .all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHigh,
                                  ),
                                ),
                                padding: const .all(16),
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text("$index"),
                                    const SizedBox(height: 4),
                                    EventItem(
                                      title: "Event",
                                      eventColor: Colors.blue,
                                    ),
                                    EventItem(
                                      title: "Event",
                                      eventColor: Colors.purple,
                                    ),
                                  ],
                                ),
                              ),
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

class EventItem extends StatelessWidget {
  final String title;
  final Color eventColor;

  const EventItem({super.key, required this.title, required this.eventColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const .symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(borderRadius: .circular(12), color: eventColor),
      child: Text(title),
    );
  }
}

class EventItemListScreen extends StatefulWidget {
  const EventItemListScreen({super.key});

  @override
  State<EventItemListScreen> createState() => EventItemListScreenState();
}

class EventItemListScreenState extends State<EventItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Event List"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(children: [const Text("Event List")]),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}

const List<String> colorList = <String>[
  "Blue",
  "Green",
  "Red",
  "Yellow",
  "Purple",
  "Orange",
];

class CreateNewEventScreen extends StatefulWidget {
  const CreateNewEventScreen({super.key});

  @override
  State<CreateNewEventScreen> createState() => CreateNewEventScreenState();
}

class CreateNewEventScreenState extends State<CreateNewEventScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool allDay = false;

  final String _colorValue = colorList.first;

  Future<void> _openStartDate() async {
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

  Future<void> _openStartTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() {
      _selectedTime = pickedTime;
    });
  }

  Future<void> _openEndDate() async {
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

  Future<void> _openEndTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() {
      _selectedTime = pickedTime;
    });
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
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .end,
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
                                  label: const Text("Event Title"),
                                  floatingLabelBehavior: .always,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  label: const Text("Description"),
                                  floatingLabelBehavior: .always,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              DropdownMenu(
                                width: 312,
                                initialSelection: _colorValue,
                                label: const Text("Color"),
                                dropdownMenuEntries: [
                                  DropdownMenuEntry(
                                    value: "Blue",
                                    label: "Blue",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Green",
                                    label: "Green",
                                  ),
                                  DropdownMenuEntry(value: "Red", label: "Red"),
                                  DropdownMenuEntry(
                                    value: "Yellow",
                                    label: "Yellow",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Purple",
                                    label: "Purple",
                                  ),
                                  DropdownMenuEntry(
                                    value: "Orange",
                                    label: "Orange",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SwitchListTile(
                                value: allDay,
                                onChanged: (bool value) {
                                  setState(() {
                                    allDay = value;
                                  });
                                },
                                title: const Text("All Day"),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: !allDay
                                    ? .spaceEvenly
                                    : .start,
                                children: [
                                  OutlinedButton(
                                    onPressed: _openStartDate,
                                    child: const Text("Start Date"),
                                  ),
                                  if (!allDay)
                                    OutlinedButton(
                                      onPressed: _openStartTime,
                                      child: const Text("Start time"),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: !allDay
                                    ? .spaceEvenly
                                    : .start,
                                children: [
                                  OutlinedButton(
                                    onPressed: _openEndDate,
                                    child: const Text("End Date"),
                                  ),
                                  if (!allDay)
                                    OutlinedButton(
                                      onPressed: _openEndTime,
                                      child: const Text("End time"),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: .end,
                                children: [
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Save Event"),
                                  ),
                                ],
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
