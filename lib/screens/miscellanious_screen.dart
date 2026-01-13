import "dart:math";
import "package:collection/collection.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";

class MiscellaniousScreen extends StatefulWidget {
  const MiscellaniousScreen({super.key});

  @override
  State<MiscellaniousScreen> createState() => MiscellaniousScreenState();
}

class MiscellaniousScreenState extends State<MiscellaniousScreen> {
  List<PricePoint> get pricePoints {
    final Random random = Random();
    final randomNumbers = <double>[];

    for (var i = 0; i <= 11; i++) {
      randomNumbers.add(random.nextDouble());
    }

    return randomNumbers
        .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: const Text("Miscellanious"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Miscellanious creations",
                        style: TextTheme.of(context).titleLarge,
                      ),
                      const SizedBox(height: 16),
                      WindowsElevenCalendar(),
                      const SizedBox(height: 16),
                      Alert(
                        alertSuccess: true,
                        leadingIcon: Icons.check_circle_outline,
                        title: "Successfully saved!",
                        subtitle:
                            "Your changes have been saved successfully. You can view updated information on the dashboard.",
                      ),
                      const SizedBox(height: 8),
                      Alert(
                        alertWarning: true,
                        leadingIcon: Icons.check_circle_outline,
                        title: "Something went wrong!",
                        subtitle:
                            "There was a problem with your request. Please try again later. If the problem persists, please contact support.",
                      ),
                      const SizedBox(height: 8),
                      Alert(
                        alertDanger: true,
                        leadingIcon: Icons.check_circle_outline,
                        title: "An error occurred!",
                        subtitle:
                            "An unexpected error occurred. Please try again later. If the problem persists, please contact support.",
                      ),
                      const SizedBox(height: 8),
                      Alert(
                        alertInfo: true,
                        leadingIcon: Icons.check_circle_outline,
                        title: "We've released a new feature!",
                        subtitle:
                            "New feature released that allows you to customize your profile. You can now add a profile picture and a bio to your profile.",
                      ),
                      const SizedBox(height: 8),
                      Alert(
                        alertSuccess: false,
                        leadingIcon: Icons.info_outline,
                        title: "New update available!",
                        subtitle:
                            "A new update is available for the application. You can now update the application to the latest version.",
                      ),
                      const SizedBox(height: 32),
                      ChartCardOne(points: pricePoints),
                      const SizedBox(height: 16),
                      PricingCard(),
                      const SizedBox(height: 16),
                      Carousel3D(),
                      const SizedBox(height: 400),
                      Row(
                        mainAxisAlignment: .center,
                        spacing: 16,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 400,
                            child: ProductPlanCards(
                              color: Colors.red,
                              title: "Basic",
                              price: "\$2.99",
                              children: [
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Sample Text Here",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  title: "Other Text Title",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  title: "Text Space Goes Here",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  title: "Description Space",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  title: "Sample Text Here",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            height: 400,
                            child: ProductPlanCards(
                              color: Colors.blue,
                              title: "Standard",
                              price: "\$5.99",
                              children: [
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Sample Text Here",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Other Text Title",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Text Space Goes Here",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  title: "Description Space",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                  title: "Sample Text Here",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            height: 400,
                            child: ProductPlanCards(
                              color: Colors.teal,
                              title: "Premium",
                              price: "\$9.99",
                              children: [
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Sample Text Here",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Other Text Title",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Text Space Goes Here",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Description Space",
                                ),
                                ProductPlanListItem(
                                  leadingIcon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: "Sample Text Here",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Carousel3D extends StatefulWidget {
  const Carousel3D({super.key});

  @override
  State<Carousel3D> createState() => Carousel3DState();
}

class Carousel3DState extends State<Carousel3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final int itemCount = 10;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, _) {
          return Transform(
            alignment: .center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(0.28)
              ..rotateY(_animationController.value * 2 * pi),
            child: Stack(
              alignment: .center,
              children: List.generate(itemCount, (index) {
                final angle = (2 * pi / itemCount) * index;

                return Transform(
                  alignment: .center,
                  transform: Matrix4.identity()
                    ..rotateY(angle)
                    ..translate(0.0, 200.0, 250.0),
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: Image.network(
                      "https://placehold.co/100x150.png?text=${index + 1}",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class ProductPlanCards extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final Color color;
  final String price;

  const ProductPlanCards({
    super.key,
    required this.title,
    required this.color,
    required this.price,
    required this.children,
  });

  @override
  State<StatefulWidget> createState() => ProductPlanCardsState();
}

class ProductPlanCardsState extends State<ProductPlanCards> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: isHovered
            ? (Matrix4.identity()..translate(0, -10))
            : Matrix4.identity(),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: .only(
              topLeft: .circular(48),
              bottomRight: .circular(48),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: .circular(48),
                bottomRight: .circular(48),
              ),
              gradient: LinearGradient(
                begin: .topLeft,
                end: .bottomRight,
                colors: [
                  widget.color.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
            padding: const .symmetric(vertical: 16),
            child: Column(
              children: [
                Padding(
                  padding: const .symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextTheme.of(
                          context,
                        ).titleLarge?.copyWith(fontWeight: .bold),
                      ),
                      Container(
                        padding: const .symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: .circular(12),
                        ),
                        child: Text(
                          widget.price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ...widget.children,
                const Spacer(),
                Padding(
                  padding: const .symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.color,
                        padding: const .symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Select Plan"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductPlanListItem extends StatelessWidget {
  final Widget leadingIcon;
  final String title;

  const ProductPlanListItem({
    super.key,
    required this.leadingIcon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          leadingIcon,
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  const PricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Card(
        child: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: .circular(12),
                    child: const Image(
                      image: NetworkImage(
                        "https://placehold.co/334x240.png?text=Prime+Pick",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Padding(
                      padding: const .only(left: 8, top: 8),
                      child: Chip(
                        padding: const .symmetric(horizontal: 2),
                        label: Row(
                          spacing: 8,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.yellow,
                            ),
                            const Text("Prime Pick"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                spacing: 8,
                crossAxisAlignment: .end,
                children: [
                  Text(
                    "\$250.000",
                    style: TextTheme.of(
                      context,
                    ).titleLarge?.copyWith(fontWeight: .bold),
                  ),
                  const Text(
                    "List Price",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                crossAxisAlignment: .end,
                spacing: 4,
                children: [
                  const Text("Guillaume Briard"),
                  const Text(
                    "• Harry koningsbergstr, 1063 AG",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                spacing: 8,
                children: [
                  Chip(
                    padding: const .symmetric(horizontal: 2),
                    label: Row(
                      spacing: 8,
                      children: [
                        const Icon(Icons.fullscreen, size: 14),
                        const Text("29m Living"),
                      ],
                    ),
                  ),
                  Chip(
                    padding: const .symmetric(horizontal: 2),
                    label: Row(
                      spacing: 8,
                      children: [
                        const Icon(Icons.home_outlined, size: 14),
                        const Text("2 Rooms"),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      const Text(
                        "Listed By",
                        style: TextStyle(fontWeight: .bold, color: Colors.grey),
                      ),
                      Chip(
                        padding: const .symmetric(horizontal: 2),
                        label: Row(
                          spacing: 8,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              child: const Text(
                                "A",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            const Text("John Doe"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .end,
                    spacing: 8,
                    children: [
                      const Text(
                        "Posted",
                        style: TextStyle(fontWeight: .bold, color: Colors.grey),
                      ),
                      const Text("2 days ago"),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text("View Details"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PricePoint {
  final double x;
  final double y;

  PricePoint({required this.x, required this.y});
}

class ChartCardOne extends StatelessWidget {
  final List<PricePoint> points;

  const ChartCardOne({super.key, required this.points});

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = "";
      switch (value.toInt()) {
        case 1:
          text = "Jan";
          break;
        case 3:
          text = "Mar";
          break;
        case 5:
          text = "May";
          break;
        case 7:
          text = "Jul";
        case 9:
          text = "Sep";
          break;
        case 11:
          text = "Now";
          break;
      }

      return Text(text);
    },
  );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            enabled: true,
            touchCallback:
                (FlTouchEvent event, LineTouchResponse? touchResponse) {},
            touchTooltipData: LineTouchTooltipData(
              tooltipBorderRadius: .circular(20),
              showOnTopOfTheChartBoxArea: true,
              fitInsideHorizontally: true,
              tooltipMargin: 0,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  return LineTooltipItem(
                    points[touchedSpot.spotIndex].y.toStringAsFixed(2),
                    const TextStyle(
                      fontSize: 10,
                      fontWeight: .w700,
                      color: Colors.white,
                    ),
                  );
                }).toList();
              },
            ),
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> indicators) {
                  return indicators.map((int index) {
                    final line = FlLine(
                      color: Colors.grey,
                      strokeWidth: 1,
                      dashArray: [2, 4],
                    );

                    return TouchedSpotIndicatorData(
                      line,
                      FlDotData(show: false),
                    );
                  }).toList();
                },
            getTouchLineEnd: (_, _) => double.infinity,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
              isCurved: true,
              dotData: FlDotData(show: false),
              color: Colors.blue,
            ),
          ],
          borderData: FlBorderData(
            border: const Border(bottom: BorderSide(), left: BorderSide()),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
}

class Alert extends StatelessWidget {
  final bool alertSuccess;
  final bool alertWarning;
  final bool alertDanger;
  final bool alertInfo;
  final IconData leadingIcon;
  final String title;
  final String subtitle;

  const Alert({
    super.key,
    this.alertSuccess = false,
    this.alertWarning = false,
    this.alertDanger = false,
    this.alertInfo = false,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: .all(
          color: alertSuccess
              ? Colors.green
              : alertWarning
              ? Colors.yellow
              : alertDanger
              ? Colors.red
              : alertInfo
              ? Colors.blue
              : Colors.white,
        ),
        borderRadius: .circular(12),
        color: alertSuccess
            ? Colors.green.withValues(alpha: 0.3)
            : alertWarning
            ? Colors.yellow.withValues(alpha: 0.3)
            : alertDanger
            ? Colors.red.withValues(alpha: 0.3)
            : alertInfo
            ? Colors.blue.withValues(alpha: 0.3)
            : Colors.grey.withValues(alpha: 0.3),
      ),
      padding: const .all(16),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Icon(
            leadingIcon,
            color: alertSuccess
                ? Colors.green
                : alertWarning
                ? Colors.yellow
                : alertDanger
                ? Colors.red
                : alertInfo
                ? Colors.blue
                : Colors.white,
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: 4,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: .bold,
                  color: alertSuccess
                      ? Colors.green
                      : alertWarning
                      ? Colors.yellow
                      : alertDanger
                      ? Colors.red
                      : alertInfo
                      ? Colors.blue
                      : Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: alertSuccess
                      ? Colors.greenAccent
                      : alertWarning
                      ? Colors.yellowAccent
                      : alertDanger
                      ? Colors.redAccent
                      : alertInfo
                      ? Colors.blueAccent
                      : Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WindowsElevenCalendar extends StatefulWidget {
  const WindowsElevenCalendar({super.key});

  @override
  State<WindowsElevenCalendar> createState() => WindowsElevenCalendarState();
}

class WindowsElevenCalendarState extends State<WindowsElevenCalendar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Row(children: [const Text("Tuesday, 13 January")]),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("January 2026"),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_drop_up),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Mo"),
                  const Text("Tu"),
                  const Text("We"),
                  const Text("Th"),
                  const Text("Fr"),
                  const Text("Sa"),
                  const Text("Su"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
