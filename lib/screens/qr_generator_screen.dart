import "package:flex_color_picker/flex_color_picker.dart";
import "package:flutter/material.dart";
import "package:qr_flutter/qr_flutter.dart";

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => QrGeneratorScreenState();
}

class QrGeneratorScreenState extends State<QrGeneratorScreen> {
  double _sliderValue = 256;
  Color _foregroundColor = Colors.white;
  Color _backgroundColor = Colors.black;

  Future<void> _openForegroundColor() async {
    bool pickedColor = await ColorPicker(
      color: _foregroundColor,
      onColorChanged: (Color newColor) {
        setState(() {
          _foregroundColor = newColor;
        });
      },
      width: 40,
      height: 40,
      borderRadius: 12,
      spacing: 10,
      runSpacing: 10,
      heading: const Text("Foreground Color"),
      wheelDiameter: 200,
      wheelWidth: 20,
    ).showPickerDialog(context);
  }

  Future<void> _openBackgroundColor() async {
    bool pickedColor = await ColorPicker(
      color: _backgroundColor,
      onColorChanged: (Color newColor) {
        setState(() {
          _backgroundColor = newColor;
        });
      },
      width: 40,
      height: 40,
      borderRadius: 12,
      spacing: 10,
      runSpacing: 10,
      heading: const Text("Background Color"),
      wheelDiameter: 200,
      wheelWidth: 20,
    ).showPickerDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("QR Generator"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 312,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "Configure QR Code",
                                style: TextTheme.of(context).titleLarge,
                              ),
                              Text(
                                "Enter your content and customize the appearance",
                                style: TextTheme.of(
                                  context,
                                ).titleSmall?.copyWith(color: Colors.grey),
                              ),

                              const SizedBox(height: 16),
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: const Text("Text"),
                                ),
                              ),

                              const SizedBox(height: 16),
                              Text(
                                "Settings",
                                style: TextTheme.of(context).titleMedium,
                              ),

                              const SizedBox(height: 16),
                              Text("Size: ${_sliderValue.toInt()}px"),
                              Slider(
                                value: _sliderValue,
                                min: 128,
                                max: 512,
                                divisions: 12,
                                onChanged: (double value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  FilledButton(
                                    onPressed: _openForegroundColor,
                                    child: const Text("Foreground"),
                                  ),
                                  FilledButton(
                                    onPressed: _openBackgroundColor,
                                    child: const Text("Background"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: .end,
                                spacing: 8,
                                children: [
                                  FilledButton(
                                    onPressed: () {},
                                    child: const Text("Reset"),
                                  ),
                                  if (isLargeScreen)
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const GeneratedQrScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text("Generate"),
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
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GeneratedQrScreen(),
                      ),
                    );
                  },
                  label: const Text("Generate"),
                ),
        );
      },
    );
  }
}

class GeneratedQrScreen extends StatefulWidget {
  const GeneratedQrScreen({super.key});

  @override
  State<GeneratedQrScreen> createState() => GeneratedQrScreenState();
}

class GeneratedQrScreenState extends State<GeneratedQrScreen> {
  final Color _foregroundColor = Colors.white;
  final Color _backgroundColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(title: const Text("Generated QR"), centerTitle: true),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 312,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "Preview and Download",
                                style: TextTheme.of(context).titleLarge,
                              ),
                              Text(
                                "Your QR code preview",
                                style: TextTheme.of(
                                  context,
                                ).titleSmall?.copyWith(color: Colors.grey),
                              ),

                              const SizedBox(height: 16),
                              Center(
                                child: QrImageView(
                                  data: '1234567890',
                                  version: QrVersions.auto,
                                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                                  backgroundColor: _backgroundColor,
                                  foregroundColor: _foregroundColor,
                                  size: 200.0,
                                ),
                              ),

                              const SizedBox(height: 16),
                              if (isLargeScreen)
                                Row(
                                  mainAxisAlignment: .center,
                                  children: [
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Download"),
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
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Icon(Icons.download_outlined),
                ),
        );
      },
    );
  }
}
