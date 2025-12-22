import "package:flutter/material.dart";
import "package:flutter_projects/screens/default_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Projects",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DefaultScreen(),
    );
  }
}
