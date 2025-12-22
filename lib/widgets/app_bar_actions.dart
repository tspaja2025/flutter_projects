import "package:flutter/material.dart";

class AppBarActions extends StatefulWidget {
  const AppBarActions({super.key});

  @override
  State<StatefulWidget> createState() => AppBarActionsState();
}

class AppBarActionsState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(right: 16),
      child: IconButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Help"),
                content: Column(
                  mainAxisSize: .min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.arrow_back),
                      title: const Text("Previous page"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.arrow_forward),
                      title: const Text("Next page"),
                    ),
                  ],
                ),
                actions: [
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.help),
      ),
    );
  }
}
