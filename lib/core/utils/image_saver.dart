import 'dart:io';
import 'dart:typed_data';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

class ImageSaver {
  static Future<void> saveToGallery(Uint8List bytes) async {
    await Gal.putImageBytes(bytes);
  }

  static Future<File> saveTemp(Uint8List bytes) async {
    final dir = await getTemporaryDirectory();
    final path = "${dir.path}/tmp_${DateTime.now().millisecondsSinceEpoch}.png";
    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
