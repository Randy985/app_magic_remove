import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:magic_remove/core/widgets/banner_ad_widget.dart';
import 'package:magic_remove/core/widgets/interstitial_ad_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:magic_remove/core/utils/image_saver.dart';
import 'package:magic_remove/features/watermark/controllers/watermark_controller.dart';
import 'package:magic_remove/core/widgets/lottie_assets.dart';

class WatermarkPage extends StatefulWidget {
  const WatermarkPage({super.key});

  @override
  State<WatermarkPage> createState() => _WatermarkPageState();
}

class _WatermarkPageState extends State<WatermarkPage> {
  final controller = WatermarkController();
  File? imageFile;
  Uint8List? resultImage;
  bool loading = false;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() {
      imageFile = File(picked.path);
      resultImage = null;
    });
  }

  Future<void> process() async {
    if (imageFile == null) return;

    // Mostrar el loading mientras procesamos la imagen
    setState(() => loading = true);

    final bytes = await imageFile!.readAsBytes();
    final output = await controller.removeWatermark(bytes);

    setState(() {
      resultImage = output;
      loading = false;
    });

    // Mostrar el anuncio después de procesar la imagen
    InterstitialAdManager.showIfNeeded(true);
  }

  Future<void> saveImage() async {
    if (resultImage == null) return;

    await ImageSaver.saveToGallery(resultImage!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Imagen guardada con éxito."),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> shareImage() async {
    if (resultImage == null) return;

    final decoded = img.decodeImage(resultImage!);
    if (decoded == null) return;

    final pngBytes = img.encodePng(decoded);
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/share_no_watermark.png';

    final file = File(path);
    await file.writeAsBytes(pngBytes);

    await Share.shareXFiles([XFile(path, mimeType: 'image/png')]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFCFD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black87,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.water_drop_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Quitar marca de agua",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: .3,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Column(
            children: [
              // Contenedor para seleccionar la imagen
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFFF3F9FA),
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                    ),
                    child: imageFile == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_outlined,
                                size: 50,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Seleccionar imagen",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(imageFile!, fit: BoxFit.contain),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: loading ? null : process,
                  icon: const Icon(Icons.opacity_rounded, color: Colors.white),
                  label: loading
                      ? const SizedBox()
                      : const Text(
                          "Quitar marca",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              if (loading) const Center(child: LoadingAnimation()),

              if (resultImage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          resultImage!,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _btn(
                            Icons.download_rounded,
                            "Guardar",
                            saveImage,
                            Colors.green,
                          ),
                          const SizedBox(width: 16),
                          _btn(
                            Icons.share_rounded,
                            "Compartir",
                            shareImage,
                            Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const BannerAdWidget(),
    );
  }

  Widget _btn(IconData icon, String label, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
