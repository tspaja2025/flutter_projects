import "package:flutter/material.dart";

class ProjectCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String description;

  const ProjectCard({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 16),
              Text(title, style: TextTheme.of(context).titleMedium),
              Text(
                description,
                textAlign: .center,
                style: TextTheme.of(
                  context,
                ).titleSmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
