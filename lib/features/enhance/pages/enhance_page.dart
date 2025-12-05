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
import 'package:magic_remove/features/enhance/controllers/enhance_controller.dart';
import 'package:magic_remove/core/widgets/lottie_assets.dart';

class EnhancePage extends StatefulWidget {
  const EnhancePage({super.key});

  @override
  State<EnhancePage> createState() => _EnhancePageState();
}

class _EnhancePageState extends State<EnhancePage> {
  final controller = EnhanceController();
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

    setState(() {
      loading = true;
    });
    final bytes = await imageFile!.readAsBytes();
    final output = await controller.enhanceImage(bytes);

    setState(() {
      resultImage = output;
      loading = false;
    });

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
    final path = '${dir.path}/enhanced_share.png';

    final file = File(path);
    await file.writeAsBytes(pngBytes);

    await Share.shareXFiles([XFile(path, mimeType: 'image/png')]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FF),
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
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.high_quality_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Mejorar calidad",
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
                      color: const Color(0xFFF2F2F9),
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                    ),
                    child: imageFile == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library_rounded,
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

              // Botón de procesar imagen
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: loading
                      ? null
                      : process, // Deshabilitar botón cuando 'loading' es true
                  icon: const Icon(
                    Icons.auto_fix_high_rounded,
                    color: Colors.white,
                  ),
                  label: loading
                      ? const SizedBox() // No mostrar nada cuando está cargando
                      : const Text(
                          "Mejorar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Mostrar la animación Lottie de loading si está cargando
              if (loading) const Center(child: LoadingAnimation()),

              // Resultados procesados
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
                          _actionBtn(
                            icon: Icons.download_rounded,
                            label: "Guardar",
                            onTap: saveImage,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 16),
                          _actionBtn(
                            icon: Icons.share_rounded,
                            label: "Compartir",
                            onTap: shareImage,
                            color: Colors.blue,
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

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
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
