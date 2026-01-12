import "package:flutter/material.dart";

// Add Logic

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => FileManagerScreenState();
}

class FileManagerScreenState extends State<FileManagerScreen> {
  bool _isChecked = false;

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
                    spacing: 8,
                    children: [
                      const Text("Files"),
                      // Breadcrumbs
                      const Spacer(),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search files...",
                          ),
                        ),
                      ),
                      MenuAnchor(
                        menuChildren: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: const Icon(Icons.folder_outlined),
                            child: const Text("New Folder"),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: const Icon(Icons.upload_file_outlined),
                            child: const Text("Upload Files"),
                          ),
                        ],
                        builder: (context, controller, child) {
                          return FilledButton.icon(
                            onPressed: () {
                              controller.isOpen
                                  ? controller.close()
                                  : controller.open();
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("New"),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      border: .all(color: Theme.of(context).dividerColor),
                      borderRadius: .circular(12),
                    ),
                    child: Table(
                      columnWidths: {
                        0: FixedColumnWidth(60),
                        5: FixedColumnWidth(70),
                      },
                      children: [
                        // Header
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text(
                                "Name",
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text(
                                "Date Modified",
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text(
                                "Type",
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text(
                                "Size",
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text(
                                "Actions",
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                          ],
                        ),

                        // Body
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: Row(
                                children: [
                                  const Icon(Icons.folder_outlined),
                                  const Text("Documents"),
                                ],
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Jan 12, 2025"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Folder"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("--"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: MenuAnchor(
                                menuChildren: [
                                  MenuItemButton(
                                    onPressed: () {},
                                    leadingIcon: const Icon(
                                      Icons.edit_outlined,
                                    ),
                                    child: const Text("Rename"),
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: Row(
                                children: [
                                  const Icon(Icons.folder_outlined),
                                  const Text("Images"),
                                ],
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Jan 12, 2025"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Folder"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("--"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: MenuAnchor(
                                menuChildren: [
                                  MenuItemButton(
                                    onPressed: () {},
                                    leadingIcon: const Icon(
                                      Icons.edit_outlined,
                                    ),
                                    child: const Text("Rename"),
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: Row(
                                children: [
                                  const Icon(Icons.folder_outlined),
                                  const Text("Projects"),
                                ],
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Jan 12, 2025"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Folder"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("--"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: MenuAnchor(
                                menuChildren: [
                                  MenuItemButton(
                                    onPressed: () {},
                                    leadingIcon: const Icon(
                                      Icons.edit_outlined,
                                    ),
                                    child: const Text("Rename"),
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: Row(
                                children: [
                                  const Icon(Icons.image_outlined),
                                  const Text("budget.xlsx"),
                                ],
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Jan 12, 2025"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("XLSX"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("2.0 MB"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
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
                                      Icons.edit_outlined,
                                    ),
                                    child: const Text("Rename"),
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: Row(
                                children: [
                                  const Icon(Icons.description_outlined),
                                  const Text("notes.txt"),
                                ],
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Jan 12, 2025"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("TXT"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("512 B"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
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
                                      Icons.edit_outlined,
                                    ),
                                    child: const Text("Rename"),
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            TableCell(
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: Row(
                                children: [
                                  const Icon(Icons.monitor),
                                  const Text("Presentation.pptx"),
                                ],
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Jan 12, 2025"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("PPTX"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("3.0 MB"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
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
                                      Icons.edit_outlined,
                                    ),
                                    child: const Text("Rename"),
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
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: Row(
                                children: [
                                  const Icon(Icons.description_outlined),
                                  const Text("report.pdf"),
                                ],
                              ),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("Jan 12, 2025"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("PDF"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
                              child: const Text("1.0 MB"),
                            ),
                            TableCell(
                              verticalAlignment: .middle,
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
                                      Icons.edit_outlined,
                                    ),
                                    child: const Text("Rename"),
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
