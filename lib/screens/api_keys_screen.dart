import "package:flutter/material.dart";

class ApiKeyGeneratorScreen extends StatefulWidget {
  const ApiKeyGeneratorScreen({super.key});

  @override
  State<StatefulWidget> createState() => ApiKeyGeneratorScreenState();
}

class ApiKeyGeneratorScreenState extends State<StatefulWidget> {
  final List<Map<String, dynamic>> mockKeys = const [
    {
      "name": "Key 1",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 2",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 3",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 4",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 5",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 6",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 7",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 8",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 9",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
    {
      "name": "Key 10",
      "key":
          "sko8fTL888lhVUTz1LRtbDTW2nWGPRMVfFZkgHIpknGQDTJGtXv9YBmngLFn0EKb410FLYGcEfayKBpX2lwnx4g",
      "created": "2025-12-15",
      "lastUsed": "Never",
      "status": "active",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        // Empty state
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "No API Keys yet.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: .w600,
                                  ),
                                ),
                                Text(
                                  "Create your first API key to get started",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // API keys
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.api_outlined),
                        title: const Text("Key Name"),
                        subtitle: const Text(
                          "Expires on Sat, Feb 7 2026",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("API Key deletion"),
                                  content: const Text(
                                    "Are you sure you want to delete this API key?",
                                  ),
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              "API Key Deleted",
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
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.api_outlined),
                        title: const Text("Key Name"),
                        subtitle: const Text(
                          "Expires on Sat, Feb 7 2026",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("API Key deletion"),
                                  content: const Text(
                                    "Are you sure you want to delete this API key?",
                                  ),
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              "API Key Deleted",
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
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.api_outlined),
                        title: const Text("Key Name"),
                        subtitle: const Text(
                          "Expires on Sat, Feb 7 2026",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("API Key deletion"),
                                  content: const Text(
                                    "Are you sure you want to delete this API key?",
                                  ),
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              "API Key Deleted",
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
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Create New API Key"),
                content: Column(
                  mainAxisSize: .min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: const Text("Key Name"),
                      ),
                    ),
                  ],
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text("API Key Created")),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Create Key"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
