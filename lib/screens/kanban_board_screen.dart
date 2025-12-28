import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";

class KanbanBoardScreen extends StatelessWidget {
  const KanbanBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Kanban Board"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      FilledButton(
                        onPressed: () {},
                        child: const Text("Add Column"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  SingleChildScrollView(
                    scrollDirection: .horizontal,
                    child: Row(
                      crossAxisAlignment: .start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: _buildKanbanColumn("To Do", "2", [
                            _buildKanbanColumnItem(
                              "Design System Setup",
                              "Create a comprehensive design system with colors, typography, and components",
                              "25/12/2025",
                              "High",
                            ),
                            _buildKanbanColumnItem(
                              "API Integration",
                              "Integrate with backend APIs for data fetching",
                              "25/12/2025",
                              "Medium",
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: _buildKanbanColumn("In Progress", "1", [
                            _buildKanbanColumnItem(
                              "User Authentication",
                              "Implement login and signup functionality",
                              "25/12/2025",
                              "High",
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: _buildKanbanColumn("Review", "1", [
                            _buildKanbanColumnItem(
                              "Mobile Responsiveness",
                              "Ensure the app works perfectly on mobile devices",
                              "25/12/2025",
                              "Medium",
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: _buildKanbanColumn("Done", "1", [
                            _buildKanbanColumnItem(
                              "Project Setup",
                              "Initialize Next.js project with TypeScript and Tailwind",
                              "25/12/2025",
                              "Low",
                            ),
                          ]),
                        ),
                      ],
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
      },
    );
  }

  Widget _buildKanbanColumn(
    String title,
    String itemCount,
    List<Widget> children,
  ) {
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            Row(
              spacing: 8,
              children: [
                Text(title),
                Chip(padding: const .all(2), label: Text(itemCount)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildKanbanColumnItem(
    String title,
    String content,
    String date,
    String priority,
  ) {
    return Card.outlined(
      child: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(title),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
            const SizedBox(height: 16),
            Text(content),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(date, style: const TextStyle(color: Colors.grey)),
                Chip(
                  padding: const .all(4),
                  label: Text(
                    priority,
                    style: TextStyle(
                      color: priority == "High"
                          ? Colors.red
                          : priority == "Medium"
                          ? Colors.orange
                          : priority == "Low"
                          ? Colors.blue
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
