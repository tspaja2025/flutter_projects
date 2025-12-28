import "package:flutter/material.dart";
import "package:flutter_projects/widgets/app_bar_actions_widget.dart";
import "package:flutter_projects/widgets/folder_card_widget.dart";

class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("File Manager"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  FolderCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ImageFolderScreen(),
                        ),
                      );
                    },
                    icon: Icons.image_outlined,
                    title: "Images",
                  ),
                  FolderCard(
                    onTap: () {},
                    icon: Icons.video_file_outlined,
                    title: "Videos",
                  ),
                  FolderCard(
                    onTap: () {},
                    icon: Icons.music_note_outlined,
                    title: "Sound",
                  ),
                  FolderCard(
                    onTap: () {},
                    icon: Icons.archive_outlined,
                    title: "Documents",
                  ),
                  FolderCard(
                    onTap: () {},
                    icon: Icons.download_outlined,
                    title: "Downloads",
                  ),
                  FolderCard(
                    onTap: () {},
                    icon: Icons.install_desktop,
                    title: "Installer files",
                  ),
                  FolderCard(
                    onTap: () {},
                    icon: Icons.folder_zip_outlined,
                    title: "Compressed",
                  ),
                  FolderCard(
                    onTap: () {},
                    icon: Icons.star_outline,
                    title: "Favorites",
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Upload"),
                    content: Column(
                      mainAxisSize: .min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Choose file",
                          ),
                        ),
                      ],
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: const Text("File Uploaded")),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("Upload"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.upload_outlined),
          ),
        );
      },
    );
  }
}

class ImageFolderScreen extends StatelessWidget {
  const ImageFolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Images Folder"),
            centerTitle: true,
            actionsPadding: const .only(right: 8),
            actions: isLargeScreen ? null : [AppBarActionsWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 8,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemCount: 32,
                          itemBuilder: (context, index) {
                            return ImagePreview(
                              imageSource: 'https://placehold.co/145/png',
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Upload"),
                    content: Column(
                      mainAxisSize: .min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Choose file",
                          ),
                        ),
                      ],
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: const Text("File Uploaded")),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("Upload"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.upload_outlined),
          ),
        );
      },
    );
  }
}

class ImagePreview extends StatelessWidget {
  final String imageSource;

  const ImagePreview({super.key, required this.imageSource});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: .center,
          child: Image(image: NetworkImage(imageSource)),
        ),
        Container(
          alignment: .bottomCenter,
          child: Text(
            "image.png",
            style: TextTheme.of(
              context,
            ).titleSmall?.copyWith(fontWeight: .bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
