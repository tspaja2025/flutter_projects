import "package:flutter/material.dart";

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<StatefulWidget> createState() => FileManagerScreenState();
}

class FileManagerScreenState extends State<StatefulWidget> {
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
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView(
                      children: [
                        _buildListCard("Images", Icons.folder_outlined),
                        _buildListCard("Videos", Icons.video_file_outlined),
                        _buildListCard("Sounds", Icons.music_note_outlined),
                        _buildListCard("Documents", Icons.description_outlined),
                        _buildListCard("Downloads", Icons.download_outlined),
                        _buildListCard("APKs", Icons.install_mobile_outlined),
                        _buildListCard("Zip", Icons.folder_zip_outlined),
                        _buildListCard("Favorited", Icons.star_outline),
                      ],
                    );
                  },
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
  }

  Widget _buildListCard(String title, IconData icon) {
    return Card(
      child: ListTile(
        contentPadding: const .symmetric(horizontal: 16),
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
