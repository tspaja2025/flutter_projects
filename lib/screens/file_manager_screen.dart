import "package:flutter/material.dart";

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => FileManagerScreenState();
}

class FileManagerScreenState extends State<FileManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("File Manager"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Search files...",
                          ),
                        ),
                      ),
                      const Spacer(),
                      MenuAnchor(
                        menuChildren: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: const Icon(Icons.add),
                            child: const Text("New Folder"),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: const Icon(Icons.upload_outlined),
                            child: const Text("Upload Files"),
                          ),
                        ],
                        builder: (context, controller, child) {
                          return FilledButton(
                            onPressed: () {
                              controller.isOpen
                                  ? controller.close()
                                  : controller.open();
                            },
                            child: const Text("Add"),
                          );
                        },
                      ),
                    ],
                  ),

                  Card(
                    child: Padding(
                      padding: const .all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Recently Uploaded Files",
                                style: TextStyle(fontWeight: .bold),
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_forward),
                                iconAlignment: .end,
                                label: const Text("View All"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Table(
                            children: [
                              // Header
                              TableRow(
                                children: [
                                  TableCell(child: const Text("Name")),
                                  TableCell(child: const Text("Size")),
                                  TableCell(child: const Text("Upload Date")),
                                  TableCell(child: const Text("Actions")),
                                ],
                              ),

                              // Body
                              TableRow(
                                children: [
                                  TableCell(
                                    child: const Text("project-proposal.docx"),
                                  ),
                                  TableCell(child: const Text("2.38 MB")),
                                  TableCell(child: const Text("Jan 5, 2026")),
                                  TableCell(
                                    child: MenuAnchor(
                                      menuChildren: [
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.download_outlined,
                                          ),
                                          child: const Text("Download"),
                                        ),
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                      builder: (context, controller, child) {
                                        return IconButton(
                                          onPressed: () {
                                            controller.isOpen
                                                ? controller.close()
                                                : controller.open();
                                          },
                                          icon: const Icon(Icons.more_vert),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: const Text("company-logo.png"),
                                  ),
                                  TableCell(child: const Text("1.14 MB")),
                                  TableCell(child: const Text("Jan 5, 2026")),
                                  TableCell(
                                    child: MenuAnchor(
                                      menuChildren: [
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.download_outlined,
                                          ),
                                          child: const Text("Download"),
                                        ),
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                      builder: (context, controller, child) {
                                        return IconButton(
                                          onPressed: () {
                                            controller.isOpen
                                                ? controller.close()
                                                : controller.open();
                                          },
                                          icon: const Icon(Icons.more_vert),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: const Text("presentation.pptx"),
                                  ),
                                  TableCell(child: const Text("5.34 MB")),
                                  TableCell(child: const Text("Jan 5, 2026")),
                                  TableCell(
                                    child: MenuAnchor(
                                      menuChildren: [
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.download_outlined,
                                          ),
                                          child: const Text("Download"),
                                        ),
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                      builder: (context, controller, child) {
                                        return IconButton(
                                          onPressed: () {
                                            controller.isOpen
                                                ? controller.close()
                                                : controller.open();
                                          },
                                          icon: const Icon(Icons.more_vert),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(child: const Text("budget.xlsx")),
                                  TableCell(child: const Text("957.03 KB")),
                                  TableCell(child: const Text("Jan 5, 2026")),
                                  TableCell(
                                    child: MenuAnchor(
                                      menuChildren: [
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.download_outlined,
                                          ),
                                          child: const Text("Download"),
                                        ),
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                      builder: (context, controller, child) {
                                        return IconButton(
                                          onPressed: () {
                                            controller.isOpen
                                                ? controller.close()
                                                : controller.open();
                                          },
                                          icon: const Icon(Icons.more_vert),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: const Text("product-video.mp4"),
                                  ),
                                  TableCell(child: const Text("150.68 MB")),
                                  TableCell(child: const Text("Jan 5, 2026")),
                                  TableCell(
                                    child: MenuAnchor(
                                      menuChildren: [
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.download_outlined,
                                          ),
                                          child: const Text("Download"),
                                        ),
                                        MenuItemButton(
                                          onPressed: () {},
                                          leadingIcon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                      builder: (context, controller, child) {
                                        return IconButton(
                                          onPressed: () {
                                            controller.isOpen
                                                ? controller.close()
                                                : controller.open();
                                          },
                                          icon: const Icon(Icons.more_vert),
                                        );
                                      },
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
