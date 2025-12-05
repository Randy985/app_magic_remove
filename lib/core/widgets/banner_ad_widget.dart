import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? ad;

  String _getAdUnitId() {
    return kReleaseMode
        ? "ca-app-pub-3268477465305430/8191754703" // REAL
        : "ca-app-pub-3940256099942544/6300978111"; // TEST
  }

  @override
  void initState() {
    super.initState();

    ad = BannerAd(
      adUnitId: _getAdUnitId(), // Usamos el método para obtener el ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (loadedAd) {
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          print('Ad failed to load: ${error.message}');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ad == null) return const SizedBox.shrink();

    return SizedBox(
      width: ad!.size.width.toDouble(),
      height: ad!.size.height.toDouble(),
      child: AdWidget(ad: ad!),
    );
  }
}
