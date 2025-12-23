import "package:flutter/material.dart";

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<StatefulWidget> createState() => EventCalendarScreenState();
}

class EventCalendarScreenState extends State<StatefulWidget> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

  final FocusNode _buttonFocusNode = FocusNode(debugLabel: "Menu");

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _today() {
    setState(() {
      _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    });
  }

  String _monthName(int month) {
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

  int _daysInMonth(DateTime date) {
    final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);

    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }

  int _firstWeekdayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday;
  }

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildWeekdayHeader(),
              const SizedBox(height: 8),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _buildCalendarGrid(today);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: _previousMonth,
          icon: const Icon(Icons.chevron_left),
        ),
        IconButton(
          onPressed: _nextMonth,
          icon: const Icon(Icons.chevron_right),
        ),
        const SizedBox(width: 8),
        Text(
          "${_monthName(_currentMonth.month)} ${_currentMonth.year}",
          style: const TextStyle(fontWeight: .bold, fontSize: 18),
        ),
        const Spacer(),
        IconButton(onPressed: _today, icon: const Icon(Icons.today_outlined)),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Row(
      children: days
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(d, style: const TextStyle(fontWeight: .w600)),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid(DateTime today) {
    final daysInMonth = _daysInMonth(_currentMonth);
    final firstWeekday = _firstWeekdayOfMonth(_currentMonth);

    final previousMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    final daysInPreviousMonth = _daysInMonth(previousMonth);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemCount: 42,
          itemBuilder: (context, index) {
            int dayNumber;
            DayType type;
            DateTime cellDate;

            if (index < firstWeekday - 1) {
              // Previous month
              dayNumber = daysInPreviousMonth - (firstWeekday - 2 - index);
              type = DayType.previous;
              cellDate = DateTime(
                previousMonth.year,
                previousMonth.month,
                dayNumber,
              );
            } else if (index >= firstWeekday - 1 + daysInMonth) {
              // Next month
              dayNumber = index - (firstWeekday - 1 + daysInMonth) + 1;
              type = DayType.next;
              cellDate = DateTime(
                _currentMonth.year,
                _currentMonth.month + 1,
                dayNumber,
              );
            } else {
              // Current month
              dayNumber = index - (firstWeekday - 1) + 1;
              type = DayType.current;
              cellDate = DateTime(
                _currentMonth.year,
                _currentMonth.month,
                dayNumber,
              );
            }

            final isToday =
                cellDate.year == _currentMonth.year &&
                cellDate.month == _currentMonth.month &&
                cellDate.day == dayNumber;

            return DayCell(
              day: dayNumber,
              type: type,
              isToday: isToday,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Day Clicked ${cellDate.toIso8601String()}"),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class DayCell extends StatelessWidget {
  final int day;
  final DayType type;
  final bool isToday;
  final VoidCallback onTap;

  const DayCell({
    super.key,
    required this.day,
    required this.type,
    required this.onTap,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor;
    final Color borderColor;

    switch (type) {
      case DayType.previous:
      case DayType.next:
        textColor = Colors.grey.shade500;
        borderColor = Colors.grey.shade800;
        break;
      case DayType.current:
        textColor = Colors.white;
        borderColor = Colors.grey.shade600;
        break;
    }

    return InkWell(
      borderRadius: .circular(8),
      onTap: onTap,
      child: Container(
        margin: const .all(4),
        decoration: BoxDecoration(
          color: isToday ? Colors.grey.shade700 : null,
          borderRadius: .circular(8),
          border: .all(color: borderColor),
        ),
        child: Align(
          alignment: .topRight,
          child: Padding(
            padding: const .all(8),
            child: Text(
              "$day",
              style: TextStyle(
                color: textColor,
                fontWeight: isToday ? .bold : .normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum DayType { previous, current, next }
