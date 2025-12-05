import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FaceCutoutController {
  final endpoint =
      "https://us-central1-picwish-proxy-service.cloudfunctions.net/picwishProxy";

  Future<Uint8List?> processFaceCutout(Uint8List bytes) async {
    final res = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"task": "face-cutout", "image": base64Encode(bytes)}),
    );

    if (res.statusCode != 200) return null;

    final json = jsonDecode(res.body);
    final url = json["data"]["image"] as String;

    if (url.isEmpty) return null;

    final imgRes = await http.get(Uri.parse(url));

    return imgRes.bodyBytes;
  }
}
