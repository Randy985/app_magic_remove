import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  static InterstitialAd? _ad;

  static int _counter = 0;
  static int every = 2; // 1 = siempre, 2 = cada 2, etc.

  static String _unitId() {
    return kReleaseMode
        ? "ca-app-pub-3268477465305430/3598011371" // real
        : "ca-app-pub-3940256099942544/1033173712"; // test
  }

  static void load() {
    InterstitialAd.load(
      adUnitId: _unitId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _ad!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              load();
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              load();
            },
          );
        },
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  static bool showIfNeeded(bool readyToProcess) {
    if (!readyToProcess) return false;

    _counter++;

    if (_counter < every) return false;
    _counter = 0;

    if (_ad != null) {
      _ad!.show();
      return true;
    }

    load();
    return false;
  }
}
