import "package:flutter/material.dart";

class FolderCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  const FolderCard({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Card(
              child: Padding(padding: const .all(16), child: Icon(icon)),
            ),
            Text(title, style: TextTheme.of(context).titleMedium),
          ],
        ),
      ),
    );
  }
}
