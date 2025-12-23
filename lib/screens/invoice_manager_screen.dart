import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions.dart";

class InvoiceManagerScreen extends StatefulWidget {
  const InvoiceManagerScreen({super.key});

  @override
  State<StatefulWidget> createState() => InvoiceManagerScreenState();
}

class InvoiceManagerScreenState extends State<StatefulWidget> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const .all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "INV-202512-01",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            label: const Text("Draft"),
                            padding: const .all(2),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                          ),
                          const Spacer(),
                          MenuAnchor(
                            childFocusNode: _buttonFocusNode,
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const Icon(Icons.visibility),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (context) =>
                                          const ViewInvoiceScreen(),
                                    ),
                                  );
                                },
                                child: const Text("Preview"),
                              ),
                              MenuItemButton(
                                leadingIcon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (context) =>
                                          const CreateInvoiceScreen(),
                                    ),
                                  );
                                },
                                child: const Text("Edit"),
                              ),
                              MenuItemButton(
                                leadingIcon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete Invoice"),
                                        content: const Text(
                                          "Are you sure you want to delete this invoice? This action cannot be undone.",
                                        ),
                                        actions: [
                                          OutlinedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Cancel"),
                                          ),
                                          FilledButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: const Text(
                                                    "Invoice Deleted",
                                                  ),
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Delete Key"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                            builder: (_, controller, _) {
                              return IconButton(
                                focusNode: _buttonFocusNode,
                                icon: const Icon(Icons.more_vert),
                                onPressed: () => controller.isOpen
                                    ? controller.close()
                                    : controller.open(),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: const [
                                Text(
                                  "John Doe",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "john.doe@john.doe",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$10.00",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: .bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      const Divider(),

                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: const [
                          MetaItem(label: "Issued", value: "Dec 19, 2025"),
                          MetaItem(label: "Due", value: "jan 18, 2026"),
                          MetaItem(label: "Items", value: "1"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const CreateInvoiceScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<StatefulWidget> createState() => CreateInvoiceScreenState();
}

class CreateInvoiceScreenState extends State<StatefulWidget> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Invoice"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(children: [const Text("Create Invoice")]),
        ),
      ),
      floatingActionButton: IconButton.filled(
        onPressed: () {},
        icon: const Icon(Icons.save),
      ),
    );
  }
}

class ViewInvoiceScreen extends StatefulWidget {
  const ViewInvoiceScreen({super.key});

  @override
  State<StatefulWidget> createState() => ViewInvoiceScreenState();
}

class ViewInvoiceScreenState extends State<StatefulWidget> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: "Menu Button");

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Invoice"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(children: [const Text("View Invoice")]),
        ),
      ),
    );
  }
}

// Helper
class MetaItem extends StatelessWidget {
  final String label;
  final String value;

  const MetaItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: Colors.grey),
        ),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
