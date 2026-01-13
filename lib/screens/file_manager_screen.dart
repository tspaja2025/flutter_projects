import "package:flutter/material.dart";

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => FileManagerScreenState();
}

class FileManagerScreenState extends State<FileManagerScreen> {
  bool _isChecked = false;

  List<File> files = [
    File(
      icon: Icons.folder_outlined,
      name: "Documents",
      dateModified: DateTime.now(),
      type: "Folder",
      size: "--",
    ),
    File(
      icon: Icons.folder_outlined,
      name: "Images",
      dateModified: DateTime.now(),
      type: "Folder",
      size: "--",
    ),
    File(
      icon: Icons.folder_outlined,
      name: "Projects",
      dateModified: DateTime.now(),
      type: "Folder",
      size: "--",
    ),
    File(
      icon: Icons.image_outlined,
      name: "budget.xlsx",
      dateModified: DateTime.now(),
      type: "XLSX",
      size: "2.0 MB",
    ),
    File(
      icon: Icons.description_outlined,
      name: "notes.txt",
      dateModified: DateTime.now(),
      type: "TXT",
      size: "512 B",
    ),
    File(
      icon: Icons.monitor,
      name: "presentation.pptx",
      dateModified: DateTime.now(),
      type: "PPTX",
      size: "3.0 MB",
    ),
    File(
      icon: Icons.description_outlined,
      name: "report.pdf",
      dateModified: DateTime.now(),
      type: "PDF",
      size: "1.0 MB",
    ),
  ];

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

                  Card(
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
                              verticalAlignment: .middle,
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
                        ...files.map((file) {
                          return TableRow(
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
                                  children: [Icon(file.icon), Text(file.name)],
                                ),
                              ),
                              TableCell(
                                verticalAlignment: .middle,
                                child: Text("${file.dateModified}"),
                              ),
                              TableCell(
                                verticalAlignment: .middle,
                                child: Text(file.type),
                              ),
                              TableCell(
                                verticalAlignment: .middle,
                                child: Text(file.size),
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
                          );
                        }),
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

class File {
  final IconData icon;
  final String name;
  final DateTime dateModified;
  final String type;
  final String size;

  File({
    required this.icon,
    required this.name,
    required this.dateModified,
    required this.type,
    required this.size,
  });
}
