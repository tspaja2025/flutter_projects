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
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title, style: TextTheme.of(context).titleMedium),
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
