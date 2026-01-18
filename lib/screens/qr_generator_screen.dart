import "dart:typed_data";
import "dart:ui" as ui;
import "package:flex_color_picker/flex_color_picker.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:path_provider/path_provider.dart";
import "package:image_gallery_saver/image_gallery_saver.dart";
import "package:share_plus/share_plus.dart";
import "dart:io";
import "package:permission_handler/permission_handler.dart";

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => QrGeneratorScreenState();
}

class QrGeneratorScreenState extends State<QrGeneratorScreen> {
  double _sliderValue = 256;
  Color _foregroundColor = Colors.white;
  Color _backgroundColor = Colors.black;
  String _errorText = "";
  bool _isGenerating = false;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = "https://example.com";
    _textEditingController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      if (_textEditingController.text.isEmpty) {
        _errorText = "Please enter text or URL";
      } else {
        _errorText = "";
      }
    });
  }

  Future<void> _openForegroundColor() async {
    await ColorPicker(
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
    await ColorPicker(
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

  void _resetSettings() {
    setState(() {
      _sliderValue = 256;
      _foregroundColor = Colors.black;
      _backgroundColor = Colors.white;
      _textEditingController.text = "https://example.com";
      _errorText = "";
    });
  }

  void _generateQR() {
    if (_textEditingController.text.isEmpty) {
      setState(() {
        _errorText = "Please enter text or URL";
      });
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    // Small delay to show loading state
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => GeneratedQrScreen(
                text: _textEditingController.text,
                size: _sliderValue,
                foregroundColor: _foregroundColor,
                backgroundColor: _backgroundColor,
              ),
            ),
          )
          .then((_) {
            setState(() {
              _isGenerating = false;
            });
          });
    });
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
                                controller: _textEditingController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: const Text("Text"),
                                  errorText: _errorText.isNotEmpty
                                      ? _errorText
                                      : null,
                                  hintText: "Enter text, URL, or contact info",
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
                                    style: FilledButton.styleFrom(
                                      backgroundColor: _foregroundColor,
                                      foregroundColor:
                                          _foregroundColor.computeLuminance() >
                                              0.5
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    child: const Text("Foreground"),
                                  ),
                                  FilledButton(
                                    onPressed: _openBackgroundColor,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: _backgroundColor,
                                      foregroundColor:
                                          _backgroundColor.computeLuminance() >
                                              0.5
                                          ? Colors.black
                                          : Colors.white,
                                    ),
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
                                    onPressed: _resetSettings,
                                    child: const Text("Reset"),
                                  ),
                                  if (isLargeScreen)
                                    FilledButton(
                                      onPressed:
                                          _errorText.isEmpty && !_isGenerating
                                          ? _generateQR
                                          : null,
                                      child: _isGenerating
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text("Generate"),
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
                  onPressed: _errorText.isEmpty && !_isGenerating
                      ? _generateQR
                      : null,
                  label: _isGenerating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Generate"),
                ),
        );
      },
    );
  }
}

class GeneratedQrScreen extends StatefulWidget {
  final String text;
  final double size;
  final Color foregroundColor;
  final Color backgroundColor;

  const GeneratedQrScreen({
    super.key,
    required this.text,
    required this.size,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  @override
  State<GeneratedQrScreen> createState() => GeneratedQrScreenState();
}

class GeneratedQrScreenState extends State<GeneratedQrScreen> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isSaving = false;
  bool _isSharing = false;

  Future<void> _saveQRCode() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      // Request storage permission
      if (Platform.isAndroid || Platform.isIOS) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          _showSnackBar("Storage permission is required to save QR code");
          return;
        }
      }

      // Capture QR code as image
      final RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save to gallery
      final result = await ImageGallerySaver.saveImage(
        pngBytes,
        quality: 100,
        name: "qr_code_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (result["isSuccess"]) {
        _showSnackBar("QR code saved to gallery!");
      } else {
        _showSnackBar("Failed to save QR code");
      }
    } catch (e) {
      _showSnackBar("Error saving QR code: $e");
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _shareQRCode() async {
    if (_isSharing) return;

    setState(() {
      _isSharing = true;
    });

    try {
      // Capture QR code as image
      final RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Create temporary file
      final tempDir = await getTemporaryDirectory();
      final file = await File(
        "${tempDir.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png",
      ).writeAsBytes(pngBytes);

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        text: "Here\"s my QR code: ${widget.text}",
        subject: "QR Code",
      );
    } catch (e) {
      _showSnackBar("Error sharing QR code: $e");
    } finally {
      setState(() {
        _isSharing = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

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

                              // QR Code with repaint boundary for capturing
                              RepaintBoundary(
                                key: _qrKey,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: widget.backgroundColor,
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: QrImageView(
                                    data: widget.text,
                                    version: QrVersions.auto,
                                    errorCorrectionLevel: QrErrorCorrectLevel.H,
                                    backgroundColor: widget.backgroundColor,
                                    foregroundColor: widget.foregroundColor,
                                    size: widget.size > 250 ? 250 : widget.size,
                                    gapless: true,
                                    eyeStyle: QrEyeStyle(
                                      eyeShape: QrEyeShape.square,
                                      color: widget.foregroundColor,
                                    ),
                                    dataModuleStyle: QrDataModuleStyle(
                                      dataModuleShape: QrDataModuleShape.square,
                                      color: widget.foregroundColor,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),
                              // QR Code content preview
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Content:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.text.length > 100
                                          ? "${widget.text.substring(0, 100)}..."
                                          : widget.text,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),
                              if (isLargeScreen)
                                Row(
                                  spacing: 8,
                                  children: [
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: _isSaving
                                            ? null
                                            : _saveQRCode,
                                        child: _isSaving
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                              )
                                            : const Text("Download"),
                                      ),
                                    ),
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: _isSharing
                                            ? null
                                            : _shareQRCode,
                                        child: _isSharing
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                              )
                                            : const Text("Download"),
                                      ),
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
