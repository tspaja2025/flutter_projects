import "dart:io";
import "dart:js_interop";
import "package:web/web.dart" as web;
import "dart:ui" as ui;
import "package:path_provider/path_provider.dart";
import "package:flex_color_picker/flex_color_picker.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_projects/widgets/app_bar_actions.dart";
import "package:qr_flutter/qr_flutter.dart";

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<StatefulWidget> createState() => QrGeneratorScreenState();
}

class QrGeneratorScreenState extends State<StatefulWidget> {
  double _currentSliderValue = 128;
  Color _foreground = Colors.black;
  Color _background = Colors.white;

  final TextEditingController _textController = TextEditingController();

  Future<void> _foregroundColor() async {
    await ColorPicker(
      color: _foreground,
      onColorChanged: (Color newColor) {
        setState(() {
          _foreground = newColor;
        });
      },
      width: 40,
      height: 40,
      borderRadius: 16,
      spacing: 10,
      runSpacing: 10,
      heading: const Text("Foreground Color"),
      wheelDiameter: 200,
      wheelWidth: 20,
    ).showPickerDialog(context);
  }

  Future<void> _backgroundColor() async {
    await ColorPicker(
      color: _background,
      onColorChanged: (Color newColor) {
        setState(() {
          _background = newColor;
        });
      },
      width: 40,
      height: 40,
      borderRadius: 16,
      spacing: 10,
      runSpacing: 10,
      heading: const Text("Foreground Color"),
      wheelDiameter: 200,
      wheelWidth: 20,
    ).showPickerDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "Configure you QR Code",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Enter your content and customize the appearance",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: const Text("Content"),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        Text(
                          "Settings",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Slider(
                          value: _currentSliderValue,
                          max: 512,
                          min: 128,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: _foregroundColor,
                          child: const Text("Foreground Color"),
                        ),
                        OutlinedButton(
                          onPressed: _backgroundColor,
                          child: const Text("Background Color"),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => const QrGeneratedScreen(),
                              ),
                            );
                          },
                          child: const Text("Generate QR Code"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QrGeneratedScreen extends StatefulWidget {
  const QrGeneratedScreen({super.key});

  @override
  State<QrGeneratedScreen> createState() => QrGeneratedScreenState();
}

class QrGeneratedScreenState extends State<QrGeneratedScreen> {
  final double _currentSliderValue = 128;
  final Color _foreground = Colors.black;
  final Color _background = Colors.white;

  final GlobalKey _qrKey = GlobalKey();

  Future<void> _downloadQr() async {
    if (kIsWeb) {
      await _downloadQrWeb();
    } else {
      await _downloadQrFile();
    }
  }

  Future<void> _downloadQrWeb() async {
    final boundary =
        _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List().toJS;
    final blob = web.Blob(JSArray.from(pngBytes));
    final url = web.URL.createObjectURL(blob);

    web.HTMLAnchorElement()
      ..setAttribute("download", "qr_code.png")
      ..click();
    web.URL.revokeObjectURL(url);
  }

  Future<void> _downloadQrFile() async {
    final boundary =
        _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
      "${directory.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png",
    );

    await file.writeAsBytes(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your QR Code"),
        centerTitle: true,
        actions: [AppBarActions()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "Preview and Download",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "You QR code will appear here",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Container(
                            padding: const .all(16),
                            decoration: BoxDecoration(
                              border: .all(),
                              borderRadius: .circular(12),
                            ),
                            child: RepaintBoundary(
                              key: _qrKey,
                              child: QrImageView(
                                data: " ",
                                version: QrVersions.auto,
                                errorCorrectionLevel: QrErrorCorrectLevel.H,
                                size: _currentSliderValue,
                                backgroundColor: _background,
                                foregroundColor: _foreground,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: _downloadQr,
                          child: const Text("Download PNG"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
