import "package:flutter/material.dart";

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => EventCalendarScreenState();
}

class EventCalendarScreenState extends State<EventCalendarScreen> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
  List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  // Generate events
  final EventProvider _eventProvider = EventProvider();

  @override
  void initState() {
    super.initState();
    _addDemoEvents();
  }

  // Demo events
  void _addDemoEvents() {
    final now = DateTime.now();
    _eventProvider.addEvent(
      Event(
        id: "1",
        title: "Team Meeting",
        description: "Weekly team sync",
        startTime: DateTime(now.year, now.month, now.day, 9, 0),
        endTime: DateTime(now.year, now.month, now.day, 10, 0),
        allDay: false,
        color: Colors.blue,
      ),
    );

    _eventProvider.addEvent(
      Event(
        id: "2",
        title: "Lunch with Client",
        description: "Business lunch",
        startTime: DateTime(now.year, now.month, now.day, 12, 30),
        endTime: DateTime(now.year, now.month, now.day, 14, 0),
        allDay: false,
        color: Colors.green,
      ),
    );

    _eventProvider.addEvent(
      Event(
        id: "3",
        title: "Birthday Party",
        description: "John\"s birthday",
        startTime: DateTime(now.year, now.month, now.day + 1),
        endTime: DateTime(now.year, now.month, now.day + 1),
        allDay: true,
        color: Colors.purple,
      ),
    );
  }

  void _navigateToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _navigateToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _goToToday() {
    setState(() {
      _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    });
  }

  List<DateTime> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    // Start from Sunday before the first day of month
    final firstDayOfCalendar = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );

    // End on Saturday after the last day of month
    final lastDayOfCalendar = lastDayOfMonth.add(
      Duration(days: (6 - lastDayOfMonth.weekday) % 7),
    );

    final days = <DateTime>[];
    DateTime currentDay = firstDayOfCalendar;

    while (currentDay.isBefore(lastDayOfCalendar) ||
        currentDay.isAtSameMomentAs(lastDayOfCalendar)) {
      days.add(currentDay);
      currentDay = currentDay.add(const Duration(days: 1));
    }

    return days;
  }

  String _getMonthYearString() {
    return "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}";
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: Text("Event Calendar"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: _navigateToPreviousMonth,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      IconButton(
                        onPressed: _navigateToNextMonth,
                        icon: const Icon(Icons.chevron_right),
                      ),
                      Text(
                        _getMonthYearString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: _goToToday,
                        icon: const Icon(Icons.today_outlined),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) => CreateNewEventScreen(
                                    eventProvider: _eventProvider,
                                  ),
                                ),
                              )
                              .then((value) {
                                setState(
                                  () {},
                                ); // Refresh calendar after adding event
                              });
                        },
                        child: const Text("New Event"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: weekdays.map((weekday) {
                      return Container(
                        width: (MediaQuery.of(context).size.width - 32) / 7,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHigh,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          weekday,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                childAspectRatio: 1.2,
                              ),
                          itemCount: daysInMonth.length,
                          itemBuilder: (context, index) {
                            final day = daysInMonth[index];
                            final isCurrentMonth =
                                day.month == _currentMonth.month;
                            final isToday = _eventProvider.isSameDay(
                              day,
                              DateTime.now(),
                            );
                            final dayEvents = _eventProvider.getEventsForDay(
                              day,
                            );

                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EventItemListScreen(
                                                date: day,
                                                events: dayEvents,
                                                eventProvider: _eventProvider,
                                              ),
                                        ),
                                      )
                                      .then((value) {
                                        setState(
                                          () {},
                                        ); // Refresh after editing/deleting events
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHigh,
                                    ),
                                    color: isToday
                                        ? Colors.blue.withValues(alpha: 0.1)
                                        : Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${day.day}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isCurrentMonth
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: dayEvents.take(3).length,
                                          itemBuilder: (context, eventIndex) {
                                            final event = dayEvents[eventIndex];
                                            return EventItem(
                                              title: event.title,
                                              eventColor: event.color,
                                            );
                                          },
                                        ),
                                      ),
                                      if (dayEvents.length > 3)
                                        Text(
                                          "+${dayEvents.length - 3} more",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                    ],
                                  ),
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
                  onPressed: () {},
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
      margin: const .only(bottom: 2),
      width: double.infinity,
      padding: const .symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: .circular(4),
        color: eventColor.withValues(alpha: 0.2),
        border: .all(color: eventColor, width: 1),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 10, color: eventColor, fontWeight: .bold),
        overflow: .ellipsis,
      ),
    );
  }
}

class EventItemListScreen extends StatefulWidget {
  final DateTime date;
  final List<Event> events;
  final EventProvider eventProvider;

  const EventItemListScreen({
    super.key,
    required this.date,
    required this.events,
    required this.eventProvider,
  });

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
          appBar: AppBar(
            title: Text(
              "Events for ${widget.date.day}/${widget.date.month}/${widget.date.year}",
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  if (widget.events.isEmpty)
                    const Expanded(
                      child: Center(child: Text("No events for this day")),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.events.length,
                        itemBuilder: (context, index) {
                          final event = widget.events[index];

                          return EventCardListTile(
                            event: event,
                            eventProvider: widget.eventProvider,
                            onEventUpdated: () {
                              setState(() {});
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
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => CreateNewEventScreen(
                              eventProvider: widget.eventProvider,
                              initialDate: widget.date,
                            ),
                          ),
                        )
                        .then((value) {
                          setState(() {}); // Refresh after adding event
                        });
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}

class EventCardListTile extends StatefulWidget {
  final Event event;
  final EventProvider eventProvider;
  final VoidCallback onEventUpdated;

  const EventCardListTile({
    super.key,
    required this.event,
    required this.eventProvider,
    required this.onEventUpdated,
  });

  @override
  State<EventCardListTile> createState() => EventCardListTileState();
}

class EventCardListTileState extends State<EventCardListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => CreateNewEventScreen(
                    eventProvider: widget.eventProvider,
                    eventToEdit: widget.event,
                  ),
                ),
              )
              .then((value) {
                widget.onEventUpdated();
              });
        },
        leading: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: .circular(999),
            color: widget.event.color,
          ),
        ),
        title: Text(widget.event.title),
        subtitle: Column(
          crossAxisAlignment: .start,
          children: [
            Text(widget.event.description),
            const SizedBox(height: 4),
            Text(
              widget.event.allDay
                  ? "All Day"
                  : "${widget.event.startTime.hour.toString().padLeft(2, "0")}:${widget.event.startTime.minute.toString().padLeft(2, "0")} - ${widget.event.endTime.hour.toString().padLeft(2, "0")}:${widget.event.endTime.minute.toString().padLeft(2, "0")}",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: MenuAnchor(
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => CreateNewEventScreen(
                          eventProvider: widget.eventProvider,
                          eventToEdit: widget.event,
                        ),
                      ),
                    )
                    .then((value) {
                      widget.onEventUpdated();
                    });
              },
              leadingIcon: const Icon(Icons.edit_outlined),
              child: const Text("Edit"),
            ),
            MenuItemButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirm Event Deletion"),
                      content: const Text(
                        "Are you sure you want to delete this Event?",
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
                            widget.eventProvider.deleteEvent(widget.event.id);
                            widget.onEventUpdated();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Event deleted.")),
                            );
                          },
                          child: const Text("Delete Event"),
                        ),
                      ],
                    );
                  },
                );
              },
              leadingIcon: const Icon(Icons.delete_outline),
              child: const Text("Delete event"),
            ),
          ],
          builder: (context, controller, child) {
            return IconButton(
              onPressed: () {
                controller.isOpen ? controller.close() : controller.open();
              },
              icon: const Icon(Icons.more_vert),
            );
          },
        ),
      ),
    );
  }
}

class CreateNewEventScreen extends StatefulWidget {
  final EventProvider eventProvider;
  final Event? eventToEdit;
  final DateTime? initialDate;

  const CreateNewEventScreen({
    super.key,
    required this.eventProvider,
    this.eventToEdit,
    this.initialDate,
  });

  @override
  State<CreateNewEventScreen> createState() => CreateNewEventScreenState();
}

class CreateNewEventScreenState extends State<CreateNewEventScreen> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;
  late TimeOfDay _selectedStartTime;
  late TimeOfDay _selectedEndTime;
  late bool _allDay;
  late String _colorValue;

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final event = widget.eventToEdit;

    // Initialize with existing event data or default values
    if (event != null) {
      _titleController = TextEditingController(text: event.title);
      _descriptionController = TextEditingController(text: event.description);
      _selectedStartDate = event.startTime;
      _selectedEndDate = event.endTime;
      _selectedStartTime = TimeOfDay.fromDateTime(event.startTime);
      _selectedEndTime = TimeOfDay.fromDateTime(event.endTime);
      _allDay = event.allDay;
      _colorValue = colorMap.entries
          .firstWhere((entry) => entry.value == event.color)
          .key;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _selectedStartDate = widget.initialDate ?? now;
      _selectedEndDate = widget.initialDate ?? now;
      _selectedStartTime = TimeOfDay.now();

      // Fix: Add 1 hour to current time properly
      final currentTime = TimeOfDay.now();
      final nowDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        currentTime.hour,
        currentTime.minute,
      );
      final oneHourLater = nowDateTime.add(const Duration(hours: 1));
      _selectedEndTime = TimeOfDay(
        hour: oneHourLater.hour,
        minute: oneHourLater.minute,
      );

      _allDay = false;
      _colorValue = colorList.first;
    }
  }

  Future<void> _openStartDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedStartDate = pickedDate;
        // If end date is before start date, update it too
        if (_selectedEndDate.isBefore(pickedDate)) {
          _selectedEndDate = pickedDate;
        }
      });
    }
  }

  Future<void> _openStartTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedStartTime = pickedTime;
      });
    }
  }

  Future<void> _openEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  Future<void> _openEndTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedEndTime = pickedTime;
      });
    }
  }

  void _saveEvent() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a title")));
      return;
    }

    final startDateTime = _allDay
        ? DateTime(
            _selectedStartDate.year,
            _selectedStartDate.month,
            _selectedStartDate.day,
          )
        : DateTime(
            _selectedStartDate.year,
            _selectedStartDate.month,
            _selectedStartDate.day,
            _selectedStartTime.hour,
            _selectedStartTime.minute,
          );

    final endDateTime = _allDay
        ? DateTime(
            _selectedEndDate.year,
            _selectedEndDate.month,
            _selectedEndDate.day,
          )
        : DateTime(
            _selectedEndDate.year,
            _selectedEndDate.month,
            _selectedEndDate.day,
            _selectedEndTime.hour,
            _selectedEndTime.minute,
          );

    if (endDateTime.isBefore(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("End time cannot be before start time")),
      );
      return;
    }

    final event = Event(
      id:
          widget.eventToEdit?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      startTime: startDateTime,
      endTime: endDateTime,
      allDay: _allDay,
      color: colorMap[_colorValue]!,
    );

    if (widget.eventToEdit != null) {
      widget.eventProvider.updateEvent(widget.eventToEdit!.id, event);
    } else {
      widget.eventProvider.addEvent(event);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.eventToEdit != null ? "Edit Event" : "Create New Event",
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
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
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    label: Text("Event Title"),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                TextField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    label: Text("Description"),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                DropdownMenu<String>(
                                  width: 280,
                                  initialSelection: _colorValue,
                                  label: const Text("Color"),
                                  dropdownMenuEntries: colorList.map((color) {
                                    return DropdownMenuEntry(
                                      value: color,
                                      label: color,
                                    );
                                  }).toList(),
                                  onSelected: (String? value) {
                                    setState(() {
                                      _colorValue = value!;
                                    });
                                  },
                                ),

                                const SizedBox(height: 16),

                                SwitchListTile(
                                  value: _allDay,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _allDay = value;
                                    });
                                  },
                                  title: const Text("All Day"),
                                ),

                                const SizedBox(height: 16),

                                Row(
                                  mainAxisAlignment: !_allDay
                                      ? MainAxisAlignment.spaceEvenly
                                      : MainAxisAlignment.start,
                                  children: [
                                    OutlinedButton(
                                      onPressed: _openStartDate,
                                      child: Text(
                                        "Start: ${_selectedStartDate.day}/${_selectedStartDate.month}/${_selectedStartDate.year}",
                                      ),
                                    ),
                                    if (!_allDay)
                                      OutlinedButton(
                                        onPressed: _openStartTime,
                                        child: Text(
                                          "${_selectedStartTime.hour.toString().padLeft(2, "0")}:${_selectedStartTime.minute.toString().padLeft(2, "0")}",
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                Row(
                                  mainAxisAlignment: !_allDay
                                      ? MainAxisAlignment.spaceEvenly
                                      : MainAxisAlignment.start,
                                  children: [
                                    OutlinedButton(
                                      onPressed: _openEndDate,
                                      child: Text(
                                        "End: ${_selectedEndDate.day}/${_selectedEndDate.month}/${_selectedEndDate.year}",
                                      ),
                                    ),
                                    if (!_allDay)
                                      OutlinedButton(
                                        onPressed: _openEndTime,
                                        child: Text(
                                          "${_selectedEndTime.hour.toString().padLeft(2, "0")}:${_selectedEndTime.minute.toString().padLeft(2, "0")}",
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 16),

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
                                      onPressed: _saveEvent,
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
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: _saveEvent,
                  child: const Icon(Icons.save_outlined),
                ),
        );
      },
    );
  }
}

// Event model
class Event {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final bool allDay;
  final Color color;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.allDay,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "allDay": allDay,
      "color": color.value,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      startTime: DateTime.parse(map["startTime"]),
      endTime: DateTime.parse(map["endTime"]),
      allDay: map["allDay"],
      color: Color(map["color"]),
    );
  }
}

// Event Provider
class EventProvider extends ChangeNotifier {
  List<Event> get events => _events;

  final List<Event> _events = [];

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void updateEvent(String id, Event updatedEvent) {
    final index = _events.indexWhere((event) => event.id == id);

    if (index != -1) {
      _events[index] = updatedEvent;
      notifyListeners();
    }
  }

  void deleteEvent(String id) {
    _events.removeWhere((event) => event.id == id);
    notifyListeners();
  }

  List<Event> getEventsForDay(DateTime date) {
    return _events.where((event) {
      return isSameDay(event.startTime, date) ||
          (event.startTime.isBefore(date) && event.endTime.isAfter(date)) ||
          isSameDay(event.endTime, date);
    }).toList();
  }

  List<Event> getEventsForMonth(DateTime month) {
    return _events.where((event) {
      return event.startTime.year == month.year &&
          event.startTime.month == month.month;
    }).toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

// Colors
const List<String> colorList = ["Blue", "Green", "Red", "Purple", "Orange"];

const Map<String, Color> colorMap = {
  "Blue": Colors.blue,
  "Green": Colors.green,
  "Red": Colors.red,
  "Purple": Colors.purple,
  "Orange": Colors.orange,
};

// class EventCalendarScreenState extends State<EventCalendarScreen> {
//   DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

//   List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

//   void _navigateToPreviousMonth() {
//     setState(() {
//       _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
//     });
//   }

//   void _navigateToNextMonth() {
//     setState(() {
//       _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
//     });
//   }

//   void _goToToday() {
//     setState(() {
//       _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final bool isLargeScreen = constraints.maxWidth >= 720;

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Event Calendar"),
//             centerTitle: true,
//           ),
//           body: SafeArea(
//             child: Padding(
//               padding: const .all(16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: _navigateToPreviousMonth,
//                         icon: const Icon(Icons.chevron_left),
//                       ),
//                       IconButton(
//                         onPressed: _navigateToNextMonth,
//                         icon: const Icon(Icons.chevron_right),
//                       ),
//                       const Text("December 2025"),
//                       const Spacer(),
//                       IconButton(
//                         onPressed: _goToToday,
//                         icon: const Icon(Icons.today_outlined),
//                       ),
//                       FilledButton(
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const CreateNewEventScreen(),
//                             ),
//                           );
//                         },
//                         child: const Text("New Event"),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: .spaceEvenly,
//                     children: weekdays.map((weekday) {
//                       return Container(
//                         width: (MediaQuery.of(context).size.width - 32) / 7,
//                         decoration: BoxDecoration(
//                           border: .all(
//                             color: Theme.of(
//                               context,
//                             ).colorScheme.surfaceContainerHigh,
//                           ),
//                         ),
//                         padding: const .all(16),
//                         child: Column(
//                           children: [
//                             Text(
//                               weekday,
//                               style: const TextStyle(fontWeight: .bold),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   Expanded(
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         return GridView.builder(
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 7,
//                               ),
//                           itemCount: 42,
//                           itemBuilder: (context, index) {
//                             return MouseRegion(
//                               cursor: SystemMouseCursors.click,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const EventItemListScreen(),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     border: .all(
//                                       color: Theme.of(
//                                         context,
//                                       ).colorScheme.surfaceContainerHigh,
//                                     ),
//                                   ),
//                                   padding: const .all(16),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       crossAxisAlignment: .start,
//                                       children: [
//                                         Text("$index"),
//                                         const SizedBox(height: 4),
//                                         EventItem(
//                                           title: "Event 1",
//                                           eventColor: Colors.blue,
//                                         ),
//                                         const SizedBox(height: 4),
//                                         EventItem(
//                                           title: "Event 2",
//                                           eventColor: Colors.purple,
//                                         ),
//                                         const SizedBox(height: 4),
//                                         EventItem(
//                                           title: "Event 3",
//                                           eventColor: Colors.green,
//                                         ),
//                                         const SizedBox(height: 4),
//                                         EventItem(
//                                           title: "Event 4",
//                                           eventColor: Colors.red,
//                                         ),
//                                         const SizedBox(height: 4),
//                                         EventItem(
//                                           title: "Event 5",
//                                           eventColor: Colors.orange,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           floatingActionButton: isLargeScreen
//               ? null
//               : FloatingActionButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const CreateNewEventScreen(),
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.add),
//                 ),
//         );
//       },
//     );
//   }
// }

// class EventItem extends StatelessWidget {
//   final String title;
//   final Color eventColor;

//   const EventItem({super.key, required this.title, required this.eventColor});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const .symmetric(horizontal: 8, vertical: 2),
//       decoration: BoxDecoration(borderRadius: .circular(12), color: eventColor),
//       child: Text(title),
//     );
//   }
// }

// class EventItemListScreen extends StatefulWidget {
//   const EventItemListScreen({super.key});

//   @override
//   State<EventItemListScreen> createState() => EventItemListScreenState();
// }

// class EventItemListScreenState extends State<EventItemListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final bool isLargeScreen = constraints.maxWidth >= 720;

//         return Scaffold(
//           appBar: AppBar(title: const Text("Event List"), centerTitle: true),
//           body: SafeArea(
//             child: Padding(
//               padding: const .all(16),
//               child: Column(
//                 children: [
//                   EventCardListTile(
//                     color: Colors.blue,
//                     title: "Event",
//                     subtitle: "Content",
//                   ),
//                   EventCardListTile(
//                     color: Colors.purple,
//                     title: "Event 2",
//                     subtitle: "Content",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           floatingActionButton: isLargeScreen
//               ? null
//               : FloatingActionButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(Icons.add),
//                 ),
//         );
//       },
//     );
//   }
// }

// class EventCardListTile extends StatefulWidget {
//   final Color color;
//   final String title;
//   final String subtitle;

//   const EventCardListTile({
//     super.key,
//     required this.color,
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   State<EventCardListTile> createState() => EventCardListTileState();
// }

// class EventCardListTileState extends State<EventCardListTile> {
//   final FocusNode _childFocusNode = FocusNode(debugLabel: "Menu Button");

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         onTap: () {},
//         leading: Container(
//           width: 20,
//           height: 20,
//           decoration: BoxDecoration(
//             borderRadius: .circular(999),
//             color: widget.color,
//           ),
//         ),
//         title: Text(widget.title),
//         subtitle: Text(widget.subtitle),
//         trailing: MenuAnchor(
//           childFocusNode: _childFocusNode,
//           menuChildren: [
//             MenuItemButton(
//               onPressed: () {},
//               leadingIcon: const Icon(Icons.edit_outlined),
//               child: const Text("Edit"),
//             ),
//             MenuItemButton(
//               onPressed: () {
//                 showDialog<void>(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text("Confirm Event Deletion"),
//                       content: const Text(
//                         "Are you sure you want to delete this Event?",
//                       ),
//                       actions: [
//                         OutlinedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text("Cancel"),
//                         ),
//                         FilledButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: const Text("Event deleted.")),
//                             );
//                           },
//                           child: const Text("Delete Event"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               leadingIcon: const Icon(Icons.delete_outline),
//               child: const Text("Delete"),
//             ),
//           ],
//           builder: (context, controller, child) {
//             return IconButton(
//               focusNode: _childFocusNode,
//               onPressed: () {
//                 if (controller.isOpen) {
//                   controller.close();
//                 } else {
//                   controller.open();
//                 }
//               },
//               icon: const Icon(Icons.more_vert),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// const List<String> colorList = ["Blue", "Green", "Red", "Purple", "Orange"];

// class CreateNewEventScreen extends StatefulWidget {
//   const CreateNewEventScreen({super.key});

//   @override
//   State<CreateNewEventScreen> createState() => CreateNewEventScreenState();
// }

// class CreateNewEventScreenState extends State<CreateNewEventScreen> {
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   bool allDay = false;

//   final String _colorValue = colorList.first;
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   Future<void> _openStartDate() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2025, 12, 26),
//       firstDate: DateTime(2025),
//       lastDate: DateTime(2026),
//     );

//     setState(() {
//       _selectedDate = pickedDate;
//     });
//   }

//   Future<void> _openStartTime() async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     setState(() {
//       _selectedTime = pickedTime;
//     });
//   }

//   Future<void> _openEndDate() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2025, 12, 26),
//       firstDate: DateTime(2025),
//       lastDate: DateTime(2026),
//     );

//     setState(() {
//       _selectedDate = pickedDate;
//     });
//   }

//   Future<void> _openEndTime() async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     setState(() {
//       _selectedTime = pickedTime;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final bool isLargeScreen = constraints.maxWidth >= 720;

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Create New Event"),
//             centerTitle: true,
//           ),
//           body: SafeArea(
//             child: Padding(
//               padding: const .all(16),
//               child: Column(
//                 crossAxisAlignment: .end,
//                 children: [
//                   Center(
//                     child: SizedBox(
//                       width: 312,
//                       child: Card(
//                         child: Padding(
//                           padding: const .all(16),
//                           child: Column(
//                             crossAxisAlignment: .start,
//                             children: [
//                               TextField(
//                                 controller: titleController,
//                                 decoration: InputDecoration(
//                                   label: const Text("Event Title"),
//                                   floatingLabelBehavior: .always,
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               TextField(
//                                 controller: descriptionController,
//                                 decoration: InputDecoration(
//                                   label: const Text("Description"),
//                                   floatingLabelBehavior: .always,
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               DropdownMenu(
//                                 width: 312,
//                                 initialSelection: _colorValue,
//                                 label: const Text("Color"),
//                                 dropdownMenuEntries: [
//                                   DropdownMenuEntry(
//                                     value: "Blue",
//                                     label: "Blue",
//                                   ),
//                                   DropdownMenuEntry(
//                                     value: "Green",
//                                     label: "Green",
//                                   ),
//                                   DropdownMenuEntry(value: "Red", label: "Red"),
//                                   DropdownMenuEntry(
//                                     value: "Yellow",
//                                     label: "Yellow",
//                                   ),
//                                   DropdownMenuEntry(
//                                     value: "Purple",
//                                     label: "Purple",
//                                   ),
//                                   DropdownMenuEntry(
//                                     value: "Orange",
//                                     label: "Orange",
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               SwitchListTile(
//                                 value: allDay,
//                                 onChanged: (bool value) {
//                                   setState(() {
//                                     allDay = value;
//                                   });
//                                 },
//                                 title: const Text("All Day"),
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment: !allDay
//                                     ? .spaceEvenly
//                                     : .start,
//                                 children: [
//                                   OutlinedButton(
//                                     onPressed: _openStartDate,
//                                     child: const Text("Start Date"),
//                                   ),
//                                   if (!allDay)
//                                     OutlinedButton(
//                                       onPressed: _openStartTime,
//                                       child: const Text("Start time"),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment: !allDay
//                                     ? .spaceEvenly
//                                     : .start,
//                                 children: [
//                                   OutlinedButton(
//                                     onPressed: _openEndDate,
//                                     child: const Text("End Date"),
//                                   ),
//                                   if (!allDay)
//                                     OutlinedButton(
//                                       onPressed: _openEndTime,
//                                       child: const Text("End time"),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment: .end,
//                                 children: [
//                                   FilledButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: const Text("Save Event"),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           floatingActionButton: isLargeScreen
//               ? null
//               : FloatingActionButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(Icons.save_outlined),
//                 ),
//         );
//       },
//     );
//   }
// }
