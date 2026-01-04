import "dart:math";
import "package:flutter/material.dart";

class MiscellaniousScreen extends StatefulWidget {
  const MiscellaniousScreen({super.key});

  @override
  State<MiscellaniousScreen> createState() => MiscellaniousScreenState();
}

class MiscellaniousScreenState extends State<MiscellaniousScreen> {
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
                child: Column(
                  children: [
                    Text(
                      "Miscellanious creations",
                      style: TextTheme.of(context).titleLarge,
                    ),
                    const SizedBox(height: 16),
                    // Carousel3D(),
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
