import "package:flutter/material.dart";

class AppBarActionsWidget extends StatefulWidget {
  const AppBarActionsWidget({super.key});

  @override
  State<AppBarActionsWidget> createState() => AppBarActionsWidgetState();
}

class AppBarActionsWidgetState extends State<AppBarActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.menu));
  }
}
