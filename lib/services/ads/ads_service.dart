import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  AdsService._();

  static final AdsService instance = AdsService._();

  Future<void> init() async {
    await MobileAds.instance.initialize();
  }
}
