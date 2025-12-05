import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class RemoveBgController {
  final endpoint =
      "https://us-central1-picwish-proxy-service.cloudfunctions.net/picwishProxy";

  Future<Uint8List?> removeBackground(Uint8List bytes) async {
    final res = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"task": "remove-bg", "image": base64Encode(bytes)}),
    );

    if (res.statusCode != 200) return null;

    final json = jsonDecode(res.body);
    final url = json["data"]["image"] as String;

    // Verifica que la URL no esté vacía
    if (url.isEmpty) return null;

    // Descargar la imagen procesada
    final imgRes = await http.get(Uri.parse(url));

    return imgRes.bodyBytes;
  }
}
