import "package:flutter/material.dart";

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Calculator"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 328,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            children: [
                              // Display
                              Row(
                                children: [
                                  const Text("5x5"),
                                  const Spacer(),
                                  const Text("="),
                                  const SizedBox(width: 8),
                                  const Text("25"),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(),
                              const SizedBox(height: 8),
                              // Buttons
                              Row(
                                spacing: 8,
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  FilledButton(
                                    onPressed: () {},
                                    child: const Text("C"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("()"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("%"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("÷"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                spacing: 8,
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("7"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("8"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("9"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("×"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                spacing: 8,
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("4"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("5"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("6"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("−"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                spacing: 8,
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("1"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("2"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("3"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("+"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                spacing: 8,
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("±"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("0"),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("."),
                                  ),
                                  FilledButton(
                                    onPressed: () {},
                                    child: const Text("="),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
