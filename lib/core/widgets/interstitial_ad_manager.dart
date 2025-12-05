import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  static InterstitialAd? _ad;
  static int _counter = 0;
  static int every = 2; // Mostrar cada 2 veces

  static String _unitId() {
    return kReleaseMode
        ? "ca-app-pub-3940256099942544/1033173712" // TEST
        : "ca-app-pub-3268477465305430/3598011371"; // REAL
  }

  static void load() {
    // Solo cargar el anuncio si MobileAds ya está inicializado
    if (_ad == null) {
      InterstitialAd.load(
        adUnitId: _unitId(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _ad = ad;
            _ad!.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                load(); // Recargar el anuncio para la próxima vez
              },
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
                load(); // Recargar el anuncio si falla
              },
            );
          },
          onAdFailedToLoad: (_) {
            _ad = null; // Si falla, nulificar el ad
          },
        ),
      );
    }
  }

  static bool showIfNeeded(bool readyToProcess) {
    if (!readyToProcess) return false;

    _counter++;

    if (_counter < every)
      return false; // Solo mostrar después de cumplir el contador
    _counter = 0;

    if (_ad != null) {
      _ad!.show(); // Mostrar el anuncio
      return true;
    }

    load(); // Cargar el anuncio si no está listo
    return false; // Si el anuncio no está listo, devolver false
  }
}
