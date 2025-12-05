import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class WatermarkController {
  final endpoint =
      "https://us-central1-picwish-proxy-service.cloudfunctions.net/picwishProxy";

  Future<Uint8List?> removeWatermark(Uint8List bytes) async {
    final res = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "task": "watermark-remove",
        "image": base64Encode(bytes),
      }),
    );

    if (res.statusCode != 200) return null;

    final json = jsonDecode(res.body);

    // Prioridad: image → file
    final url = json["data"]?["image"] ?? json["data"]?["file"];

    if (url == null || url is! String) return null;

    final imgRes = await http.get(Uri.parse(url));
    return imgRes.bodyBytes;
  }
}
