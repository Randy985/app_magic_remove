import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class InpaintController {
  final endpoint =
      "https://us-central1-picwish-proxy-service.cloudfunctions.net/picwishProxy";

  Future<Uint8List?> inpaint({
    required Uint8List imageBytes,
    required Uint8List maskBytes,
  }) async {
    print("INPAINT → Iniciando request");
    print("INPAINT → Tamaño imagen: ${imageBytes.length} bytes");
    print("INPAINT → Tamaño máscara: ${maskBytes.length} bytes");

    try {
      final res = await http
          .post(
            Uri.parse(endpoint),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "task": "remove-objects",
              "image": base64Encode(imageBytes),
              "mask": base64Encode(maskBytes),
              "sync": 0, // sync: 0 para tarea asincrónica
            }),
          )
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              throw Exception('Timeout: La operación tardó más de 60 segundos');
            },
          );

      if (res.statusCode != 200) {
        print("INPAINT → Error HTTP: ${res.statusCode}");
        return null;
      }

      final json = jsonDecode(res.body);
      final data = json["data"];

      if (data == null || data["task_id"] == null) {
        print("INPAINT → Error: No se recibió task_id");
        return null;
      }

      final taskId = data["task_id"];
      print("INPAINT → Tarea iniciada, task_id: $taskId");

      // Polling para verificar el estado de la tarea
      return await _pollTaskStatus(taskId);
    } catch (e, stackTrace) {
      print("INPAINT → Excepción: $e");
      print("INPAINT → StackTrace: $stackTrace");
      return null;
    }
  }

  Future<Uint8List?> _pollTaskStatus(String taskId) async {
    int retries = 5;
    while (retries > 0) {
      try {
        final result = await http
            .get(
              Uri.parse("$endpoint/inpaint/$taskId"),
              headers: {"X-API-KEY": "PICWISH_KEY"},
            )
            .timeout(const Duration(seconds: 30));

        if (result.statusCode != 200) {
          print("INPAINT → Error al obtener estado: ${result.statusCode}");
          return null;
        }

        final data = jsonDecode(result.body)["data"];
        if (data != null && data["state"] == 1) {
          final imageUrl = data["image"];
          if (imageUrl == null || imageUrl.isEmpty) {
            print("INPAINT → Error: No se recibió URL de imagen");
            return null;
          }

          return await _downloadImage(imageUrl);
        }
      } catch (e) {
        print("INPAINT → Error fetching task result: $e");
      }

      retries--;
      await Future.delayed(
        Duration(seconds: 5),
      ); // Esperar 5 segundos antes de reintentar
    }

    print("INPAINT → Error: La tarea no se completó correctamente");
    return null;
  }

  Future<Uint8List?> _downloadImage(String imageUrl) async {
    try {
      final imgRes = await http
          .get(Uri.parse(imageUrl))
          .timeout(const Duration(seconds: 30));

      if (imgRes.statusCode != 200) {
        print("INPAINT → Error descargando imagen: ${imgRes.statusCode}");
        return null;
      }

      print(
        "INPAINT → ✓ Imagen descargada exitosamente (${imgRes.bodyBytes.length} bytes)",
      );
      return imgRes.bodyBytes;
    } catch (e) {
      print("INPAINT → Error al descargar la imagen: $e");
      return null;
    }
  }
}
