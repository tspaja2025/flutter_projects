import "package:flutter/material.dart";
import "package:flutter_projects/screens/default_screen.dart";

void main() {
  runApp(const MyProjects());
}

class MyProjects extends StatelessWidget {
  const MyProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      title: "Flutter Projects",
      home: const DefaultScreen(),
    );
  }
}
