import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_painter_v2/flutter_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_remove/core/utils/image_saver.dart';
import 'package:magic_remove/core/widgets/banner_ad_widget.dart';
import 'package:magic_remove/features/inpaint/controllers/inpaint_controller.dart';
import 'package:magic_remove/core/widgets/interstitial_ad_manager.dart';
import 'package:image/image.dart' as img;

class InpaintPage extends StatefulWidget {
  const InpaintPage({super.key});

  @override
  State<InpaintPage> createState() => _InpaintPageState();
}

class _InpaintPageState extends State<InpaintPage> {
  final controller = InpaintController();
  File? imageFile;
  Uint8List? resultImage;
  ui.Image? loadedImage;

  late PainterController painter;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    painter = PainterController(
      settings: const PainterSettings(
        freeStyle: FreeStyleSettings(
          color: Colors.black,
          strokeWidth: 35,
          mode: FreeStyleMode.draw,
        ),
      ),
    );
  }

  Future<ui.Image> _loadUiImage(File file) async {
    final data = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(data);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    painter.clearDrawables();

    final uiImage = await _loadUiImage(File(picked.path));
    loadedImage = uiImage;
    painter.background = uiImage.backgroundDrawable;

    setState(() {
      imageFile = File(picked.path);
      resultImage = null;
    });
  }

  Future<void> process() async {
    if (imageFile == null) return;
    if (InterstitialAdManager.showIfNeeded(true)) return;

    setState(() => loading = true);

    try {
      final originalBytes = await imageFile!.readAsBytes();
      final decodedOriginal = img.decodeImage(originalBytes)!;
      final ow = decodedOriginal.width;
      final oh = decodedOriginal.height;

      painter.background = loadedImage!.backgroundDrawable;

      final uiImage = await painter.renderImage(
        Size(ow.toDouble(), oh.toDouble()),
      );

      final raw = await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
      final bytes = raw!.buffer.asUint8List();

      // CORRECCIÓN: Crear máscara RGB (no RGBA)
      final mask = img.Image(width: ow, height: oh);

      for (int i = 0; i < bytes.length; i += 4) {
        final r = bytes[i];
        final g = bytes[i + 1];
        final b = bytes[i + 2];
        final a = bytes[i + 3];

        final x = (i ~/ 4) % ow;
        final y = (i ~/ 4) ~/ ow;

        // Detectar trazo negro con alfa > 0
        final isDrawn = (r < 50 && g < 50 && b < 50 && a > 128);

        // CORRECCIÓN CRÍTICA: Invertir la lógica
        // Áreas dibujadas (a remover) = BLANCO (255)
        // Áreas no dibujadas (a mantener) = NEGRO (0)
        final maskValue = isDrawn ? 255 : 0;

        mask.setPixelRgb(x, y, maskValue, maskValue, maskValue);
      }

      // Guardar máscara para debug
      final maskBytes = Uint8List.fromList(img.encodePng(mask, level: 0));
      final debug = File("/storage/emulated/0/Download/mask_debug.png");
      await debug.writeAsBytes(maskBytes);
      print("MASK DEBUG SAVED: Áreas blancas = objetos a remover");

      // Llamar al servicio
      final out = await controller.inpaint(
        imageBytes: originalBytes,
        maskBytes: maskBytes,
      );

      if (out == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error al procesar. Intenta de nuevo."),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        setState(() {
          resultImage = out;
        });
      }
    } catch (e) {
      print("ERROR EN PROCESS: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> saveImage() async {
    if (resultImage == null) return;
    await ImageSaver.saveToGallery(resultImage!);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Imagen guardada"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.brush_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Borrar objetos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: imageFile == null
                  ? const Center(
                      child: Text(
                        "Selecciona una imagen",
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : FlutterPainter.builder(
                      controller: painter,
                      builder: (context, painterWidget) {
                        if (loadedImage == null) return painterWidget;

                        return Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                              width: loadedImage!.width.toDouble(),
                              height: loadedImage!.height.toDouble(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: painterWidget,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          if (resultImage != null)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      resultImage!,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: saveImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Guardar"),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: loading ? null : (imageFile == null ? pickImage : process),
        label: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(imageFile == null ? "Seleccionar" : "Procesar"),
        icon: Icon(imageFile == null ? Icons.photo : Icons.cleaning_services),
      ),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
