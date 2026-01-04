import "package:flutter/material.dart";

class ProjectCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String description;
  final String itemCount;

  const ProjectCard({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.description,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: .none,
            children: [
              // Main card
              Container(
                width: 312,
                constraints: BoxConstraints(minHeight: 250),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: const .only(
                    topLeft: .circular(64),
                    bottomLeft: .circular(12),
                    bottomRight: .circular(12),
                    topRight: .circular(12),
                  ),
                ),
                padding: const .fromLTRB(24, 32, 24, 80),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Icon(icon),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      style: TextStyle(fontSize: 20, fontWeight: .w800),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      textAlign: .center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Top ribbon tab
              Positioned(
                top: 32,
                right: -2,
                child: ClipPath(
                  clipper: RibbonClipper(),
                  child: Container(
                    height: 30,
                    width: 120,
                    color: Colors.indigo,
                  ),
                ),
              ),

              // Bottom ribbon
              Positioned(
                bottom: -25,
                left: -15, // extend beyond card
                right: -15,
                child: Stack(
                  clipBehavior: .none,
                  alignment: .topCenter,
                  children: [
                    // Ribbon background
                    Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: .vertical(bottom: .circular(32)),
                      ),
                    ),

                    // Badge
                    Positioned(
                      top: -42, // pull it upward like translateY(-50%)
                      child: RibbonBadge(itemCount: itemCount),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RibbonBadge extends StatelessWidget {
  final String itemCount;

  const RibbonBadge({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: const Color(0xFF393E7F), width: 8),
      ),
      alignment: Alignment.center,
      child: Text(
        itemCount,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width * 0.1, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(_) => false;
}
