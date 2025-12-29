import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";

class ApiKeysScreen extends StatefulWidget {
  const ApiKeysScreen({super.key});

  @override
  State<ApiKeysScreen> createState() => ApiKeysScreenState();
}

class ApiKeysScreenState extends State<ApiKeysScreen> {
  final FocusNode _childFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("API Keys"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CreateApiKeyScreen(),
                            ),
                          );
                        },
                        child: const Text("Create API Key"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Empty State
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const .all(16),
                        child: Column(
                          children: [
                            Text(
                              "No API Keys yet.",
                              style: TextTheme.of(context).titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text("Create your first API key to get started."),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Non Empty state
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(child: const Text("A")),
                      title: const Text("API Name"),
                      subtitle: const Text(
                        "Never used • Expires on Sun, Mar 22 2026",
                      ),
                      trailing: MenuAnchor(
                        childFocusNode: _childFocusNode,
                        menuChildren: [
                          MenuItemButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("API Key refreshed."),
                                ),
                              );
                            },
                            leadingIcon: const Icon(Icons.refresh),
                            child: const Text("Refresh Key"),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Key Deletion"),
                                    content: const Text(
                                      "Are you sure you want to delete this API key?",
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                "API Key deleted.",
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text("Delete Key"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            leadingIcon: const Icon(Icons.delete_outline),
                            child: const Text("Delete Key"),
                          ),
                        ],
                        builder: (context, controller, child) {
                          return IconButton(
                            focusNode: _childFocusNode,
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: const Icon(Icons.more_vert),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateApiKeyScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}

class CreateApiKeyScreen extends StatefulWidget {
  const CreateApiKeyScreen({super.key});

  @override
  State<CreateApiKeyScreen> createState() => CreateApiKeyScreenState();
}

class CreateApiKeyScreenState extends State<CreateApiKeyScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Create New API Key"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 312,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            crossAxisAlignment: .end,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  floatingLabelBehavior: .always,
                                  label: const Text("Key Name"),
                                ),
                              ),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Create Key"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}
