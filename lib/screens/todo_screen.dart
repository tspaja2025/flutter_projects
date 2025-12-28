import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("To Do"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(children: [const Text("To Do Screen")]),
            ),
          ),
        );
      },
    );
  }
}
